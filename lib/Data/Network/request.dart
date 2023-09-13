class LoginRequest {
  final String? email;
  final String? password;

  LoginRequest({this.email,this.password});
}

class RegisterRequest {
  final String? username;
  final String? countryMobileCode;
  final String? phone;
  final String? email;
  final String? password;
  final String? profilePicture;

  RegisterRequest({this.username,this.countryMobileCode,this.phone,this.email,this.password,this.profilePicture});
}