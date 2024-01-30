import 'package:dartz/dartz.dart';
import 'package:tut_app/Data/Data_Sources/remote_data_source.dart';
import 'package:tut_app/Data/Mapper/mapper.dart';

import 'package:tut_app/Data/Network/failure.dart';
import 'package:tut_app/Data/Network/request.dart';
import 'package:tut_app/Data/Response/response.dart';
import 'package:tut_app/Domain/Models/home_data_model.dart';
import 'package:tut_app/Domain/Models/user_model.dart';
import 'package:tut_app/Presentation/Store_Details/store_details_screen.dart';

import '../../Domain/Models/store_details_model.dart';
import '../../Domain/Repository/repository.dart';
import '../Data_Sources/local_data_source.dart';
import '../Network/connection_checker.dart';
import '../Network/error_handler.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSourceImpl;
  final LocalDataSource localDataSourceImpl;
  final ConnectionCheckerImpl _connectionCheckerImpl;

  RepositoryImpl(this.remoteDataSourceImpl, this._connectionCheckerImpl, this.localDataSourceImpl);

  @override
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequest loginRequest) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final response = await remoteDataSourceImpl.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
              message: ResponseMessages.DEFAULT,
              code: ApiInternalStatus.FAILURE));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final response = await remoteDataSourceImpl.forgotPassword(email);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.message!);
        } else {
          return Left(Failure(
              message: ResponseMessages.DEFAULT,
              code: ApiInternalStatus.FAILURE));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationModel>> register(
      RegisterRequest registerRequest) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {

        final response = await remoteDataSourceImpl.register(registerRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
              message: ResponseMessages.DEFAULT,
              code: ApiInternalStatus.FAILURE));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {

    try {
      var response = await localDataSourceImpl.getHomeData();
      print("Local");
      return Right(response.toDomain());
    }
    catch (e) {
      if (await _connectionCheckerImpl.hasConnection) {
        try {
          return remoteDataSourceImpl.getHomeData().then((response) {
            if(response.status == ApiInternalStatus.SUCCESS) {
              print("Remote");
              localDataSourceImpl.saveHomeData(response);
              return Right(response.toDomain());
            } else {
              return Left(Failure(message: ResponseMessages.DEFAULT, code: ApiInternalStatus.FAILURE));
            }
          });
        } catch (e) {
          return Left(ErrorHandler.handle(e).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET.getFailure());
      }
    }



  }

  @override
  Future<Either<Failure, StoreDetailsModel>> getStoreDetails() async {
    try
    {
      var response = await localDataSourceImpl.getStoreDetails();
      return Right(response.toDomain());
    }
    catch(e)
    {
      if(await _connectionCheckerImpl.hasConnection) {

        try {
          print("try");
          final response = await remoteDataSourceImpl.getStoreDetails();
          if(response.status == ApiInternalStatus.SUCCESS) {
            localDataSourceImpl.saveStoreDetails(response);
            print("Remote");
            return Right(response.toDomain());
          } else {
            return Left(Failure(message: ResponseMessages.DEFAULT, code: ApiInternalStatus.FAILURE));
          }
        } catch (e) {
          print("catch");
          return Left(ErrorHandler.handle(e).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET.getFailure());
      }
    }




  }


}


