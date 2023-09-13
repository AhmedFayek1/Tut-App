import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../App/constants.dart';
import '../Response/response.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServiceClientApi{

  factory AppServiceClientApi(Dio dio, {String baseUrl}) = _AppServiceClientApi;

  @POST("/user/login")
  Future<AuthenticationResponse> login(@Field("email") String email,@Field("password") String password);

  @POST("/user/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/user/register")
  Future<AuthenticationResponse> register(
      @Field("user-name") String name,
      @Field("mobile-country-code") String code,
      @Field("phone") String phone,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profile-picture") String profilePicture,
      );

  @GET("/home")
  Future<HomeResponse> getHomeData();

  @GET("/store/1")
  Future<StoreDetailsResponse> getStoreDetails();
}

//command to generate the api
//flutter pub run build_runner build --delete-conflicting-outputs
