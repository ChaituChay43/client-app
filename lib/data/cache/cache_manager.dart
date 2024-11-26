class CacheManager {
  Map<String, dynamic> cache = {};
  Map<String, DateTime> cacheTimestamps = {};

  void cacheData(String key, dynamic data) {
    cache[key] = data;
    cacheTimestamps[key] = DateTime.now();
  }

  dynamic getCachedData(String key) {
    if (cache.containsKey(key) &&
        DateTime.now().difference(cacheTimestamps[key]!) < const Duration(seconds: 120)) {
      return cache[key];
    }
    return null;
  }
}
