import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  late final JournalCubit _journalCubit;
  late final FavouriteCubit _favouriteCubit;

  @override
  void initState() {
    super.initState();
    _journalCubit = context.read<JournalCubit>();
    _favouriteCubit = context.read<FavouriteCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (ctx, state) {
        if (state is RefreshAudioRecordings) {
          _journalCubit.refresh();
          _favouriteCubit.refresh();
          return;
        }
      },
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
}
