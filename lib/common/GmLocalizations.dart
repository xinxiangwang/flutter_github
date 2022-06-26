import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class GmLocalizations {
  GmLocalizations(this.isZh);
  bool isZh = false;
  static GmLocalizations? of(BuildContext context) {
    return Localizations.of<GmLocalizations>(context, GmLocalizations);
  }
  String get title => isZh ? "標題" : "title";
  String get home => isZh ? "主頁" : "home";
  String get login => isZh ? "登錄" : "login";
  String get theme => isZh ? "主题" : "theme";
  String get language => isZh ? "语言" : "language";
  String get yes => isZh ? "确认" : "yes";
  String get cancel => isZh ? "取消" : "cancel";
  String get logout => isZh ? "登出" : "logout";
  String get logoutTip => isZh ? "是否登出?" : "ready to logout?";
  String get pswd => isZh ? "请输入密码" : "password";
  String get username => isZh ? "请输入账号" : "username";
  String get pswdValidate => isZh ? "密码必填" : "password is required";
  String get usernameValidate => isZh ? "账号必填" : "username is required";
  String get auto => isZh ? "自动" : "auto";
}

class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations> {
  const GmLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<GmLocalizations> load(Locale locale) {
    return SynchronousFuture<GmLocalizations>(
      GmLocalizations(locale.languageCode == 'zh')
    );
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<GmLocalizations> old) {
    return false;
  }
}