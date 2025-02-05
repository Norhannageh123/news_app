import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/Ui/home/Catergory%20Details/cubit/bloc_observer.dart';
import 'package:news_app/di/di_inject.dart';
import 'package:news_app/provider/languageProvider.dart';
import 'package:news_app/provider/themeProvider.dart';
import 'package:news_app/utls/app_theme.dart';
import 'package:news_app/Ui/home/home.dart';
import 'package:news_app/utls/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   Bloc.observer = MyBlocObserver();
   var directory=await getApplicationCacheDirectory();
   Hive.init(directory.path);
   Hive.registerAdapter(SourceResponseAdapter());
   Hive.registerAdapter(SourceAdapter());
   configureDependencies();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LanguageProvider()),
    ChangeNotifierProvider(create: (context) => AppThemeProvider()),
  ], child: const NewsApp()));
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.routeHome,
      routes: {
        AppRoutes.routeHome: (context) => const HomePage(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
