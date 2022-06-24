import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:untitled/common/global.dart';

class CacheObject {
  CacheObject(this.response): timestamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timestamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => response.realUri.hashCode;

}

class NetCache extends Interceptor {
  var cache = LinkedHashMap<String, CacheObject>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!Global.profile.cache!.enable) {
      return handler.next(options);
    }
    bool isRefresh = options.extra['refresh'] == true;
    if (isRefresh) {
      if (options.extra['list'] == true) {
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        cache.remove(options.uri.toString());
      }
    }
    if (options.extra['noCache'] != true && options.method.toLowerCase() != 'get') {
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        if ((DateTime.now().millisecondsSinceEpoch - ob.timestamp) / 100 < Global.profile.cache!.maxAge) {
          return handler.resolve(ob.response);
        } else {
          cache.remove(key);
        }
      }
    }
    handler.next(options);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Global.profile.cache!.enable) {
      _saveCache(response);
    }
    handler.next(response);
  }
  _saveCache(Response object) {
    RequestOptions options = object.requestOptions;
    if (options.extra['noCache'] != true && options.method.toLowerCase() == 'get') {
      if (cache.length == Global.profile.cache!.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }
}