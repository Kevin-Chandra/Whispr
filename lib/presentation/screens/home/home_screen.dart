import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:whispr/presentation/bloc/app_lock/app_lock_cubit.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/bloc/audio_recordings/audio_recordings_cubit.dart';
import 'package:whispr/presentation/bloc/favourite/favourite_cubit.dart';
import 'package:whispr/presentation/bloc/home/home_cubit.dart';
import 'package:whispr/presentation/bloc/journal/journal_cubit.dart';
import 'package:whispr/presentation/router/router_config.gr.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_bottom_navigation_bar.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/util/extensions.dart';
import 'package:whispr/util/mixin/app_lock_mixin.dart';
import 'package:whispr/util/mixin/lifecycle_state_aware_mixin.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<JournalCubit>(create: (context) => JournalCubit()),
        BlocProvider<FavouriteCubit>(create: (context) => FavouriteCubit()),
        BlocProvider<AudioPlayerCubit>(create: (context) => AudioPlayerCubit()),
        BlocProvider<AudioRecordingsCubit>(
            create: (context) => AudioRecordingsCubit()),
      ],
      child: this,
    );
  }
}

class _HomeScreenState extends State<HomeScreen>
    with LifeCycleStateAwareMixin<HomeScreen>, AppLockMixin<HomeScreen> {
  late final HomeCubit _homeCubit;
  late final JournalCubit _journalCubit;
  late final FavouriteCubit _favouriteCubit;
  late final AudioPlayerCubit _audioPlayerCubit;
  late final AppLockCubit _appLockCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = context.read<HomeCubit>();
    _audioPlayerCubit = context.read<AudioPlayerCubit>();
    _journalCubit = context.read<JournalCubit>();
    _favouriteCubit = context.read<FavouriteCubit>();
    _appLockCubit = context.read<AppLockCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeCubit, HomeState>(listener: (ctx, state) {
          if (state is RefreshAudioRecordings) {
            _journalCubit.refresh();
            _favouriteCubit.refresh();
            return;
          }

          if (state is AppLockConfigLoadedState) {
            showLockedScreenForAppLaunch();
            FlutterNativeSplash.remove();
            return;
          }
        }),
        BlocListener<AppLockCubit, AppLockState>(listener: (ctx, state) {
          if (state is AuthenticatedState) {
            didUnlock();
            _appLockCubit.resetState();
            return;
          }
        }),
      ],
      child: AutoTabsRouter.tabBar(
        physics: NeverScrollableScrollPhysics(),
        routes: const [
          VoiceRecordHomeRoute(),
          FavouriteRoute(),
          JournalRoute(),
          SettingsRoute(),
        ],
        builder: (context, child, controller) {
          final tabsRouter = AutoTabsRouter.of(context);
          final activeIndex = tabsRouter.activeIndex;
          return WhisprGradientScaffold(
            gradient: _resolveScaffoldGradient(index: activeIndex),
            bottomNavigationBar: WhisprBottomNavigationBar(
              controller: controller,
            ),
            body: child,
            appBar: WhisprAppBar(
              title: _resolveAppBarTitle(index: activeIndex),
              enableBackButton: false,
              isDarkBackground: activeIndex == 0,
            ),
          );
        },
      ),
    );
  }

  @override
  void onDetached() {
    super.onDetached();
    _audioPlayerCubit.close();
  }

  @override
  void onPause() {
    super.onPause();
    _audioPlayerCubit.pause();
  }

  @override
  void dispose() {
    _audioPlayerCubit.stop();
    super.dispose();
  }

  Gradient _resolveScaffoldGradient({required int index}) {
    if (index == 0) {
      return WhisprGradient.purpleGradient;
    } else {
      return WhisprGradient.whiteBlueWhiteGradient;
    }
  }

  String _resolveAppBarTitle({required int index}) {
    switch (index) {
      case 0:
        return context.strings.voice_record;
      case 1:
        return context.strings.favourite;
      case 2:
        return context.strings.journal;
      default:
        return context.strings.settings;
    }
  }

  @override
  bool get shouldShowLockScreen => _homeCubit.appLockedEnabled;
}
