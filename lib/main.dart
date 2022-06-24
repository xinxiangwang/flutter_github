import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:untitled/common/GmLocalizations.dart';
import 'package:untitled/common/global.dart';
import 'package:untitled/routes/gome_page.dart';

void main() {
  Global.init().then((e) => runApp(const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel())
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (context, themeModel, localeModel, child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeModel.theme
            ),
            onGenerateTitle: (context) {
              return GmLocalizations.of(context)!.title;
            },
            locale: localeModel.getLocale(),
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('zh', 'CN')
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GmLocalizationsDelegate()
            ],
            localeListResolutionCallback: (_locale, supportedLocales) {
              if(localeModel.getLocale() != null) {
                return localeModel.getLocale();
              } else {
                Locale locale;
                if (supportedLocales.contains(_locale![0])) {
                  locale = _locale[0];
                } else {
                  locale = const Locale('en', 'US');
                }
                return locale;
              }
            },
            home: HomeRoute(),
            routes: <String, WidgetBuilder>{

            },
          );
        },
      ),
    );
  }
}
