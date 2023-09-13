import 'dart:async';
import 'dart:io';

import 'package:tut_app/Domain/Usecases/register_usecase.dart';
import 'package:tut_app/Presentation/Common/State_Renderer/state_renderer.dart';
import 'package:tut_app/Presentation/Common/State_Renderer/state_renderer_implementer.dart';

import '../../Base_View_Model/base_view_model.dart';
import '../../Common/Data_Class/data_class.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _usernameController =
  StreamController<String>.broadcast();
  final StreamController _mobileNumberController =
  StreamController<String>.broadcast();
  final StreamController _emailController =
  StreamController<String>.broadcast();
  final StreamController _passwordController =
  StreamController<String>.broadcast();
  final StreamController _profilePictureController =
  StreamController<File>.broadcast();
  final StreamController _isAllDataValidController =
  StreamController<void>.broadcast();
  final StreamController isUserRegisteredSuccessfullyStreamController = StreamController<bool>();


  RegisterObject _registerObject = RegisterObject("", "", "", "", "", "");

  final RegisterUsecase _registerUsecase;

  RegisterViewModel(this._registerUsecase);

  //Sinks
  @override
  Sink get usernameSink => _usernameController.sink;

  @override
  Sink get mobileNumberSink => _mobileNumberController.sink;

  @override
  Sink get emailSink => _emailController.sink;

  @override
  Sink get passwordSink => _passwordController.sink;

  @override
  Sink get profilePictureSink => _profilePictureController.sink;

  @override
  Sink get isAllDataValidSink => _isAllDataValidController.sink;

  //Setters
  @override
  void setUserName(String value) {
    usernameSink.add(value);
    _registerObject = _registerObject.copyWith(userName: value);
    isAllDataValidSink.add(null);
  }

  @override
  void setMobileNumber(String value) {
    mobileNumberSink.add(value);
    _registerObject = _registerObject.copyWith(mobileNumber: value);
    isAllDataValidSink.add(null);
  }

  @override
  void setCountryMobileCode(String value) {
    _registerObject = _registerObject.copyWith(countryMobileCode: value);
    isAllDataValidSink.add(null);
  }

  @override
  void setEmail(String value) {
    emailSink.add(value);
    _registerObject = _registerObject.copyWith(email: value);
    isAllDataValidSink.add(null);
  }

  @override
  void setPassword(String value) {
    passwordSink.add(value);
    _registerObject = _registerObject.copyWith(password: value);
    isAllDataValidSink.add(null);
  }

  @override
  void setProfilePicture(File value) {
    profilePictureSink.add(value);
    _registerObject = _registerObject.copyWith(profilePicture: value.path);
    isAllDataValidSink.add(null);
  }

  //Streams
  @override
  Stream<bool> get usernameStream => _usernameController.stream.map((username) => validateUserName(username));
  bool validateUserName(String username) => username.isNotEmpty;


  @override
  Stream<bool> get mobileNumberStream => _mobileNumberController.stream.map((mobileNumber) => validateMobileNumber(mobileNumber));
  bool validateMobileNumber(String mobileNumber) => mobileNumber.isNotEmpty;

  @override
  Stream<bool> get emailStream => _emailController.stream.map((email) => validateEmail(email));
  bool validateEmail(String email) => email.isNotEmpty;

  @override
  Stream<bool> get passwordStream => _passwordController.stream.map((password) => validatePassword(password));
  bool validatePassword(String password) => password.isNotEmpty;

  @override
  Stream<File> get profilePictureStream => _profilePictureController.stream.map((file) => file);

  @override
  Stream<bool> get isAllDataValidStream => _isAllDataValidController.stream.map((_) => validateAllData());
  bool validateAllData() {
    if (_registerObject.userName.isNotEmpty &&
        _registerObject.countryMobileCode.isNotEmpty &&
        _registerObject.mobileNumber.isNotEmpty &&
        _registerObject.email.isNotEmpty &&
        _registerObject.password.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> register() async {
    inputStateSink.add(LoadingStateRenderer(stateRenderer: States.popUpLoadingState));
    (await _registerUsecase.execute(RegisterUseCaseInputs(
        _registerObject.userName,
        _registerObject.countryMobileCode,
        _registerObject.mobileNumber,
        _registerObject.email,
        _registerObject.password,
        "",
    )))
        .fold((failure) {
          print("failure");
      inputStateSink.add(ErrorStateRenderer(stateRenderer: States.popUpErrorState, message: failure.message!));
    }, (success) {
          print("success");
      inputStateSink.add(ContentStateRenderer());
      isUserRegisteredSuccessfullyStreamController.add(true);
    });
  }




  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _usernameController.close();
    _mobileNumberController.close();
    _emailController.close();
    _passwordController.close();
    _profilePictureController.close();
    isUserRegisteredSuccessfullyStreamController.close();
    super.dispose();
  }
}

abstract class RegisterViewModelInput {
  Sink get usernameSink;

  Sink get mobileNumberSink;

  Sink get emailSink;

  Sink get passwordSink;

  Sink get profilePictureSink;

  void setUserName(String value);

  void setMobileNumber(String value);

  void setCountryMobileCode(String value);

  void setEmail(String value);

  void setPassword(String value);

  void setProfilePicture(File value);

  void register();

  Sink get isAllDataValidSink;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get usernameStream;

  Stream<bool> get mobileNumberStream;

  Stream<bool> get emailStream;

  Stream<bool> get passwordStream;

  Stream<File> get profilePictureStream;

  Stream<bool> get isAllDataValidStream;
}
