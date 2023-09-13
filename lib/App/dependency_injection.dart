import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/Data/Network/app_api.dart';
import 'package:tut_app/Domain/Usecases/login_usecase.dart';
import 'package:tut_app/Domain/Usecases/register_usecase.dart';
import 'package:tut_app/Presentation/Login/View_Model/login_view_model.dart';
import '../Data/Data_Sources/local_data_source.dart';
import '../Data/Data_Sources/remote_data_source.dart';
import '../Data/Network/connection_checker.dart';
import '../Data/Network/dio_factory.dart';
import '../Data/Repository_Implementer/repository_implementer.dart';
import '../Domain/Repository/repository.dart';
import '../Domain/Usecases/forgot_password_usecase.dart';
import '../Domain/Usecases/home_usecase.dart';
import '../Domain/Usecases/store_details_usecase.dart';
import '../Presentation/Forgot_Password/View_Model/view_model.dart';
import '../Presentation/Home/pages/Home/Home_Model_View/home_model_view.dart';
import '../Presentation/Register/View_Model/register_view_model.dart';
import '../Presentation/Store_Details/store_details_viewmoel.dart';
import 'app_preferences.dart';

final instance = GetIt.instance;

Future<void> getAppModules() async {
  //shared preferences module
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //app preferences module
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //Network Info module
  instance.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(InternetConnectionChecker()));

  //dio factory module
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //dio module
  Dio dio = await instance<DioFactory>().getDio();

  //app client service module
  instance.registerLazySingleton<AppServiceClientApi>(
      () => AppServiceClientApi(dio));

  //remote data source module
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClientApi>()));

  //local data source module
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //data repository module
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), ConnectionCheckerImpl(InternetConnectionChecker()), LocalDataSourceImpl()));
}

Future<void> initLoginModules() async  {
  if(!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

Future<void> initForgotPasswordModules() async  {
  if(!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
  }
}

Future<void> initRegisterModules() async  {
  if(!GetIt.I.isRegistered<RegisterUsecase>()) {
    instance.registerFactory<RegisterUsecase>(() => RegisterUsecase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

Future<void> initHomeModules() async
{
  if(!GetIt.I.isRegistered<HomeUsecase>()) {
    instance.registerFactory<HomeUsecase>(() => HomeUsecase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

Future<void> initStoreDetailsModules() async
{
  if(!GetIt.I.isRegistered<StoreDetailsUsecase>()) {
    instance.registerFactory<StoreDetailsUsecase>(() => StoreDetailsUsecase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(() => StoreDetailsViewModel(instance()));
  }
}
