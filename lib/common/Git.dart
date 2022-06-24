import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/common/global.dart';
import 'package:untitled/models/index.dart';

class Git {
  Git([this.context]) {
    _options = Options(extra: {'context': context});
  }
  BuildContext? context;
  late Options _options;
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.github.com/',
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
      "application/vnd.github.symmetra-preview+json",
    }
  ));
  static void init() {
    dio.interceptors.add(Global.netCache);
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  Future<User> login(String login, String pwd) async {
    String basic = 'Basic ' + base64.encode(utf8.encode('$login:$pwd'));
    var res = await dio.get(
      '/user',
      options: _options.copyWith(
        headers: {
          HttpHeaders.authorizationHeader: basic
        },
        extra: {
          'noCache': true
        }
      )
    );
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    Global.profile.token = basic;
    return User.fromJson(res.data);
  }

  Future<List<Repo>> getRepos({
    Map<String, dynamic>? queryParams,
    refresh = false
}) async {
    if (refresh) {
      _options.extra!.addAll({ 'refresh': true, 'list': true });
    }
    var res = await dio.get<List>(
      'user/repos',
      queryParameters: queryParams,
      options: _options
    );
    return res.data!.map((e) => Repo.fromJson(e)).toList();
  }
}