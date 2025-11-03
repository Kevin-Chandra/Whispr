import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:whispr/domain/use_case/settings/get_has_completed_onboarding_use_case.dart';
import 'package:whispr/lang/generated/whispr_localizations.dart';
import 'package:whispr/presentation/bloc/app_lock/app_lock_cubit.dart';
import 'package:whispr/presentation/router/router_config.dart';
import 'package:whispr/presentation/themes/themes.dart';

import 'data/local/hive/hive_db.dart';
import 'di/di_config.dart';
import 'domain/use_case/settings/get_is_app_lock_enabled_use_case.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await configureDependencies();
  await di.get<HiveLocalStorage>().init();

  final shouldLockApp = await di.get<GetIsAppLockEnabledUseCase>().call();
  final hasCompletedOnboarding =
      await di.get<GetHasCompletedOnboardingUseCase>().call();

  final appRouter = WhisprRouter(shouldShowOnboarding: !hasCompletedOnboarding);
  runApp(MyApp(
    appRouter: appRouter,
    shouldLockApp: shouldLockApp,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
    required this.shouldLockApp,
  });

  final WhisprRouter appRouter;
  final bool shouldLockApp;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppLockCubit>(
      create: (context) => AppLockCubit(),
      child: MaterialApp.router(
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
          return MediaQuery(
            data: mediaQueryData.copyWith(
              textScaler: scale,
              alwaysUse24HourFormat: true,
            ),
            child: widget ?? const SizedBox(),
          );
        },
      ),
    );
  }
}
