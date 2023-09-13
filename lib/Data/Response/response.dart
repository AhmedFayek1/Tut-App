import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class BaseResponse
{
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class UserResponse
{
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numOfNotifications')
  int? numOfNotifications;

  UserResponse({this.id, this.name, this.numOfNotifications});

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class ContactResponse
{
  @JsonKey(name: 'phone')
  String? phoneNumber;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'link')
  String? link;

  ContactResponse({this.phoneNumber,this.email,this.link});

  factory ContactResponse.fromJson(Map<String, dynamic> json) => _$ContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse
{
  @JsonKey(name: 'user')
  UserResponse? user;
  @JsonKey(name: 'contact')
  ContactResponse? contactResponse;

  AuthenticationResponse({this.user,this.contactResponse});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;
  ForgotPasswordResponse(this.support);

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class ServiceResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  ServiceResponse({this.id,this.title,this.image});

  factory ServiceResponse.fromJson(Map<String, dynamic> json) => _$ServiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class BannerResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'link')
  String? link;
  @JsonKey(name: 'image')
  String? image;

  BannerResponse({this.id,this.title,this.link,this.image});

  factory BannerResponse.fromJson(Map<String, dynamic> json) => _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}


@JsonSerializable()
class StoresResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  StoresResponse({this.id,this.title,this.image});

  factory StoresResponse.fromJson(Map<String, dynamic> json) => _$StoresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse extends BaseResponse {
  @JsonKey(name: 'banners')
  List<BannerResponse>? banners;
  @JsonKey(name: 'services')
  List<ServiceResponse>? services;
  @JsonKey(name: 'stores')
  List<StoresResponse>? stores;

  HomeDataResponse({this.banners,this.services,this.stores});

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) => _$HomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse({this.data});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'services')
  String? services;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'about')
  String? about;

  StoreDetailsResponse({this.id,this.title,this.image,this.details,this.about});

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) => _$StoreDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}

//command to generate the response.g.dart file
//flutter pub run build_runner build --delete-conflicting-outputs

