import 'package:dartz/dartz.dart';
import 'package:tut_app/Domain/Repository/repository.dart';
import '../../Data/Network/failure.dart';
import 'base_usecase.dart';

class ForgotPasswordUseCase extends BaseUseCase<String,String> {
  final Repository _authenticationRepository;

  ForgotPasswordUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _authenticationRepository.forgotPassword(input);
  }
}
