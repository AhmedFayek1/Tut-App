import 'dart:async';
import 'package:tut_app/Presentation/Common/State_Renderer/state_renderer_implementer.dart';
import '../../../Domain/Usecases/login_usecase.dart';
import '../../Base_View_Model/base_view_model.dart';
import '../../Common/Data_Class/data_class.dart';
import '../../Common/State_Renderer/state_renderer.dart';


class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs {

  final StreamController<String> _userNameController = StreamController<String>.broadcast();
  final StreamController<String> _passwordController = StreamController<String>.broadcast();
  final StreamController _isAllDataValid = StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController = StreamController<bool>();

  LoginObject _loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void start() {
    inputStateSink.add(ContentStateRenderer());
  }


  @override
  void dispose() {
    super.dispose();
    _userNameController.close();
    _passwordController.close();
    _isAllDataValid.close();
  }



  @override
  void login() async {
    inputStateSink.add(LoadingStateRenderer(stateRenderer: States.popUpLoadingState));
    (
        await _loginUseCase.execute(LoginUseCaseInput(email: _loginObject.userName, password: _loginObject.password))
    ). fold((left)  {
        inputStateSink.add(ErrorStateRenderer(stateRenderer: States.popUpErrorState, message: left.message!));
    },
            (right)  {
                  inputStateSink.add(ContentStateRenderer());
                  isUserLoggedInSuccessfullyStreamController.add(true);
            });
  }

  @override
  Sink get userNameInput => _userNameController.sink;

  @override
  Sink get passwordInput => _passwordController.sink;

  @override
  Sink get isAllDataValidInput => _isAllDataValid.sink;

  @override
  Stream<bool> get userNameOutput => _userNameController.stream.map((userName) => validateUserName(userName));

  bool validateUserName(String userName) => userName.isNotEmpty;

  @override
  Stream<bool> get passwordOutput => _passwordController.stream.map((password) => validatePassword(password));

  bool validatePassword(String password) => password.isNotEmpty;

  @override
  Stream<bool> get isAllDataValidOutput => _isAllDataValid.stream.map((_) => validateAllData());

  bool validateAllData() {
    return validateUserName(_loginObject.userName) && validatePassword(_loginObject.password);
  }




  @override
  void setUserName(String userName) {
    userNameInput.add(userName);
    _loginObject = _loginObject.copyWith(userName: userName);
    isAllDataValidInput.add(null);
  }

  @override
  void setPassword(String password) {
    passwordInput.add(password);
    _loginObject = _loginObject.copyWith(password: password);
    isAllDataValidInput.add(null);
  }

}

abstract class LoginViewModelInputs {
  void setUserName(String userName);

  void setPassword(String password);

  void login();

  Sink get userNameInput;

  Sink get passwordInput;

  Sink get isAllDataValidInput;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get userNameOutput;

  Stream<bool> get passwordOutput;

  Stream<bool> get isAllDataValidOutput;
}
