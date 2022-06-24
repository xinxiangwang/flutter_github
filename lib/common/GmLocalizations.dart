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