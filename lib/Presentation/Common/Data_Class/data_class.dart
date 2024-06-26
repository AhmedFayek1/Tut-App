
import 'package:freezed_annotation/freezed_annotation.dart';
part 'data_class.freezed.dart';

@freezed
class LoginObject with _$LoginObject {

  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {

  factory RegisterObject(String userName, String countryMobileCode, String mobileNumber, String email, String password, String profilePicture) = _RegisterObject;
}

