
import 'package:dartz/dartz.dart';
import 'package:tut_app/Data/Network/failure.dart';
import 'package:tut_app/Domain/Models/user_model.dart';

import '../../Data/Network/request.dart';
import '../../Presentation/Store_Details/store_details_screen.dart';
import '../Models/home_data_model.dart';
import '../Models/store_details_model.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationModel>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, AuthenticationModel>> register(RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHomeData();
  Future<Either<Failure, StoreDetailsModel>> getStoreDetails();
}
