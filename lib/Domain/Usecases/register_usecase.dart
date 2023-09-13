import 'package:dartz/dartz.dart';
import 'package:tut_app/Data/Network/failure.dart';
import 'package:tut_app/Domain/Models/user_model.dart';
import 'package:tut_app/Domain/Repository/repository.dart';
import '../../Data/Network/request.dart';
import 'base_usecase.dart';


class RegisterUsecase extends BaseUseCase<RegisterUseCaseInputs,AuthenticationModel>
{
  final Repository _repository;
  RegisterUsecase(this._repository);
  @override
  Future<Either<Failure, AuthenticationModel>> execute(input) async {
    return await _repository.register(RegisterRequest(
      username: input.username,
      countryMobileCode: input.countryMobileCode,
      phone: input.mobileNumber,
      email: input.email,
      password: input.password,
      profilePicture: input.profilePicture
    ));
  }

  }


class RegisterUseCaseInputs
{
  final String username;
  final String countryMobileCode;
  final String mobileNumber;
  final String email;
  final String password;
  final String profilePicture;

  RegisterUseCaseInputs(this.username, this.countryMobileCode, this.mobileNumber, this.email, this.password, this.profilePicture);
}
