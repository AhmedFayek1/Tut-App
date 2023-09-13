import 'package:dartz/dartz.dart';
import 'package:tut_app/Data/Network/request.dart';
import 'package:tut_app/Domain/Usecases/base_usecase.dart';
import '../../Data/Network/failure.dart';
import '../Models/user_model.dart';
import '../Repository/repository.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, AuthenticationModel> {
  final Repository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, AuthenticationModel>> execute(input) {
    return _authenticationRepository.login(LoginRequest(email: input.email,password: input.password!));
  }

}

class LoginUseCaseInput
{
    final String? email;
    final String? password;

    LoginUseCaseInput({this.email,this.password});
}


