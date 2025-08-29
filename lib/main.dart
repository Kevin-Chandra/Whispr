import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whispr/lang/generated/whispr_localizations.dart';
import 'package:whispr/presentation/router/router_config.dart';
import 'package:whispr/presentation/themes/themes.dart';

import 'data/local/hive/hive_db.dart';
import 'di/di_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await di.get<HiveLocalStorage>().init();

  final appRouter = WhisprRouter();
  runApp(MyApp(
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final WhisprRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Whispr',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
      theme: WhisprThemes.lightTheme,
      themeMode: ThemeMode.light,
      supportedLocales: WhisprLocalizations.supportedLocales,
      localizationsDelegates: const [
        WhisprLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
