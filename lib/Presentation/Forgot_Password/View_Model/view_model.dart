import 'dart:async';

import 'package:tut_app/Presentation/Base_View_Model/base_view_model.dart';

import '../../../Domain/Usecases/forgot_password_usecase.dart';
import '../../Common/State_Renderer/state_renderer.dart';
import '../../Common/State_Renderer/state_renderer_implementer.dart';

class ForgotPasswordViewModel extends BaseViewModel with ForgotPasswordViewModelInput,ForgotPasswordViewModelOutput
{
  final StreamController email = StreamController<String>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var _email = "";


  @override
  void start() {
    inputStateSink.add(ContentStateRenderer());
  }

  @override
  Future<void> forgotPassword() async {
    inputStateSink.add(LoadingStateRenderer(stateRenderer: States.popUpLoadingState));
    (await _forgotPasswordUseCase.execute(_email)).
    fold((left) {
      inputStateSink.add(ErrorStateRenderer(stateRenderer: States.popUpErrorState, message: left.message!));
    }, (right) {
      inputStateSink.add(ContentStateRenderer());
    });
  }

  @override
  Sink get userNameInput => email.sink;

  @override
  Stream<bool> get userNameOutput => email.stream.map((email) => isEmailValid(email));

  bool isEmailValid(String email) {
    return email.contains("@") && email.isNotEmpty;
  }

  @override
  void dispose() {
    email.close();
  }

  @override
  void setEmail(String email) {
    userNameInput.add(email);
    _email = email;
  }
}

abstract class ForgotPasswordViewModelInput
{
  void forgotPassword();

  void  setEmail(String email);
  Sink get userNameInput;
}


abstract class ForgotPasswordViewModelOutput
{
  Stream<bool> get userNameOutput;
}
