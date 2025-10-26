import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:whispr/lang/generated/whispr_localizations.dart';
import 'package:whispr/presentation/router/router_config.dart';
import 'package:whispr/presentation/screens/app_lock/app_locked_screen.dart';
import 'package:whispr/presentation/themes/themes.dart';

import 'data/local/hive/hive_db.dart';
import 'di/di_config.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
      builder: (context, widget) {
        final mediaQueryData = MediaQuery.of(context);

        // Ensure the text scale stays within a specified range.
        final scale = mediaQueryData.textScaler.clamp(
          minScaleFactor: 1.0, // Minimum scale factor allowed.
          maxScaleFactor: 1.0, // Maximum scale factor allowed.
        );

        // For now we do not allow any scaling.

        return AppLock(
          initiallyEnabled: true,
          initialBackgroundLockLatency: Duration.zero,
          lockScreenBuilder: (context) => AppLockedScreen(),
          builder: (context, arg) => MediaQuery(
            data: mediaQueryData.copyWith(
              textScaler: scale,
              alwaysUse24HourFormat: true,
            ),
            child: widget ?? const SizedBox(),
          ),
        );
      },
    );
  }
}
