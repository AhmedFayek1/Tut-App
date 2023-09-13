class Service
{
  int id;
  String title;
  String image;

  Service({required this.id,required this.title,required this.image});
}

class BannerModel
{
  int id;
  String title;
  String link;
  String image;

  BannerModel({required this.id,required this.title,required this.link,required this.image});
}

class Store
{
  int id;
  String title;
  String image;

  Store({required this.id,required this.title,required this.image});
}

class HomeDataModel
{
  List<Service> services;
  List<BannerModel> banners;
  List<Store> stores;
  HomeDataModel({required this.services,required this.banners,required this.stores});
}

class HomeObject
{
  HomeDataModel? homeDataModel;
  HomeObject({this.homeDataModel});
}