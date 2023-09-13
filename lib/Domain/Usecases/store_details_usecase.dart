import 'package:dartz/dartz.dart';
import 'package:tut_app/Data/Repository_Implementer/repository_implementer.dart';
import 'package:tut_app/Domain/Usecases/base_usecase.dart';
import 'package:tut_app/Presentation/Store_Details/store_details_screen.dart';

import '../../Data/Network/failure.dart';
import '../Models/store_details_model.dart';
import '../Repository/repository.dart';

class StoreDetailsUsecase extends BaseUseCase<void, StoreDetailsModel> {
  final Repository _repository;
  StoreDetailsUsecase(this._repository);

  @override
  Future<Either<Failure, StoreDetailsModel>> execute(void input) {
    return _repository.getStoreDetails();
  }
}