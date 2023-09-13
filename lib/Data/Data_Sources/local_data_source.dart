import 'package:tut_app/Data/Network/error_handler.dart';

import '../Response/response.dart';

String homeResponseKey = "homeResponseKey";
int homeCacheInterval = 1000 * 60;

String storeDetailsResponseKey = "storeDetailsResponseKey";
int storeDetailsCacheInterval = 1000 * 60;
abstract class LocalDataSource
{
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeData(HomeResponse homeResponse);

  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> saveStoreDetails(StoreDetailsResponse storeDetailsResponse);



  void clearCache();

  void clearCacheByKey(String key);
}

class LocalDataSourceImpl implements LocalDataSource {

  final Map<String,CachedItem> _cachedItems = Map();

  @override
  Future<void> saveHomeData(HomeResponse homeResponse) async {
    _cachedItems[homeResponseKey] = CachedItem(homeResponse);
  }

  @override
  Future<void> saveStoreDetails(StoreDetailsResponse storeDetailsResponse) async {
    _cachedItems[storeDetailsResponseKey] = CachedItem(storeDetailsResponse);
    print("DATA CACHED SUCCESSFULLY!");
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
    CachedItem cachedItem = _cachedItems[storeDetailsResponseKey]!;

    if(cachedItem != null && !cachedItem.isExpired(storeDetailsCacheInterval))
    {
      return cachedItem.data;
    }
    else
    {
      throw Exception(DataSource.CACHE_TIMEOUT);
    }
  }

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem cachedItem = _cachedItems[homeResponseKey]!;

    if(cachedItem != null && !cachedItem.isExpired(homeCacheInterval))
    {
      return cachedItem.data;
    }
    else
    {
      throw Exception(DataSource.CACHE_TIMEOUT);
    }
  }

  @override
  void clearCache() {
    _cachedItems.clear();
  }

  @override
  void clearCacheByKey(String key) {
    _cachedItems.remove(key);
  }

}

class CachedItem
{
  dynamic data;

  int date = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem
{
  bool isExpired(int expiryTime)
  {
    bool isValid;
    isValid = DateTime.now().millisecondsSinceEpoch - expiryTime <= homeCacheInterval;

    return isValid;
  }
}