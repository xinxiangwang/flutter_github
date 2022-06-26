import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/common/CacheObject.dart';
import 'package:untitled/common/Git.dart';
import 'package:untitled/models/index.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static late SharedPreferences _prefs;
  static Profile profile = Profile();
  static NetCache netCache = NetCache();
  static List<MaterialColor> get themes => _themes;
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    } else {
      profile = Profile()..theme = 0;
    }
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;
    Git.init();
  }

  static saveProfile() =>
      _prefs.setString('profile', jsonEncode(profile.toJson()));
}

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNotifier {
  User? get user => _profile.user;
  bool get isLogin => user != null;
  set user(User? user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier {
  MaterialColor get theme => Global.themes
      .firstWhere((e) => e.value == _profile.theme, orElse: () => Colors.blue);
  set theme(MaterialColor color) {
    if (color != theme) {
      _profile.theme = color[500]?.value as num;
      notifyListeners();
    }
  }
}

class LocaleModel extends ProfileChangeNotifier {
  Locale? getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale?.split("_");
    if (t == null) return null;
    return Locale(t[0], t[1]);
  }
  String? get locale => _profile.locale;
  set locale(String? locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}
