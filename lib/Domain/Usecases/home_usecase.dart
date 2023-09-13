import 'package:dartz/dartz.dart';
import 'package:tut_app/Domain/Models/home_data_model.dart';
import 'package:tut_app/Domain/Usecases/base_usecase.dart';

import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';

class HomeUsecase extends BaseUseCase<void, HomeObject>
{
  final Repository _repository;
  HomeUsecase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) {
    return _repository.getHomeData();
  }
}