
import 'package:tut_app/Domain/Models/home_data_model.dart';

import '../Network/app_api.dart';
import '../Network/request.dart';
import '../Response/response.dart';


abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails();
}


class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClientApi _appServiceClientApi;

  RemoteDataSourceImpl(this._appServiceClientApi);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClientApi.login(loginRequest.email!, loginRequest.password!);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return  await _appServiceClientApi.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClientApi.register(
        registerRequest.username!,
        registerRequest.countryMobileCode!,
        registerRequest.phone!,
        registerRequest.email!,
        registerRequest.password!,
        "");
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClientApi.getHomeData();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
    return _appServiceClientApi.getStoreDetails();
  }
}