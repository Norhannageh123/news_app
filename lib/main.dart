import 'package:flutter/material.dart';
import 'package:news_app/provider/languageProvider.dart';
import 'package:news_app/utls/app_theme.dart';
import 'package:news_app/Ui/home/home.dart';
import 'package:news_app/utls/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(ChangeNotifierProvider(
    create:(context)=> LanguageProvider(),
    child: const NewsApp()));
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.routeHome,
      routes: {
        AppRoutes.routeHome:(context)=> const HomePage(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

    );
  }
}