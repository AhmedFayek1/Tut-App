import 'package:tut_app/Data/Response/response.dart';
import 'package:tut_app/App/extensions.dart';

import '../../Domain/Models/home_data_model.dart';
import '../../Domain/Models/store_details_model.dart';
import '../../Domain/Models/user_model.dart';


extension UserResponseMapper on UserResponse
{
  UserModel toDomain()
  {
    return UserModel(id.orNull(), name.orNull(), numOfNotifications.orZero());
  }
}


extension ContactResponseMapper on ContactResponse
{
  ContactModel toDomain()
  {
    return ContactModel(phoneNumber.orNull(), email.orNull(), link.orNull());
  }
}


extension AuthenticationResponseMapper on AuthenticationResponse
{
  AuthenticationModel toDomain()
  {
    return AuthenticationModel(user!.toDomain(), contactResponse!.toDomain());
  }
}


extension ForgotPasswordResponseMapper on ForgotPasswordResponse
{
  String toDomain()
  {
    return support.orNull();
  }
}


extension ServicesResponseMapper on ServiceResponse
{
  Service toDomain()
  {
    return Service(id: id.orZero(), title: title.orNull(), image: image.orNull());
  }
}


extension BannersResponseMapper on BannerResponse
{
  BannerModel toDomain()
  {
    return BannerModel(id: id.orZero(), title: title.orNull(), link: link.orNull(), image: image.orNull());
  }
}


extension StoresResponseMapper on StoresResponse
{
  Store toDomain()
  {
    return Store(id: id.orZero(), title: title.orNull(), image: image.orNull());
  }
}


extension HomeDataResponseMapper on HomeResponse
{
  HomeObject toDomain()
  {
    var services = (this.data?.services ?? []).map((service) => service.toDomain()).toList();
    var banners = (this.data?.banners ?? []).map((banner) => banner.toDomain()).toList();
    var stores = (this.data?.stores ?? []).map((store) => store.toDomain()).toList();

    var data = HomeDataModel(services: services, banners: banners, stores: stores,);
    return HomeObject(homeDataModel: data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse
{
  StoreDetailsModel toDomain()
  {
    var storeDetails = StoreDetailsModel(id: id.orZero(), title: title.orNull(), image: image.orNull(), details: details.orNull(), about: about.orNull(), services: services.orNull());
    return storeDetails;
  }
}