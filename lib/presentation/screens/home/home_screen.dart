import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/bloc/audio_recordings/audio_recordings_cubit.dart';
import 'package:whispr/presentation/router/navigation_paths.dart';
import 'package:whispr/presentation/screens/home/home_body.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
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
        BlocProvider<AudioPlayerCubit>(create: (context) => AudioPlayerCubit()),
        BlocProvider<AudioRecordingsCubit>(
            create: (context) => AudioRecordingsCubit()),
      ],
      child: this,
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayerCubit _audioPlayerCubit;
  late AudioRecordingsCubit _audioRecordingsCubit;

  @override
  void initState() {
    super.initState();
    _audioPlayerCubit = context.read<AudioPlayerCubit>();
    _audioRecordingsCubit = context.read<AudioRecordingsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return WhisprGradientScaffold(
      gradient: WhisprGradient.purpleGradient,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [WhisprAppBar(title: context.strings.home)];
        },
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.router.pushPath(WhisprNavigationPaths.recordAudioPath);
              },
              child: const Text("Here"),
            ),
            ElevatedButton(
              onPressed: () {
                _audioPlayerCubit.playAudio();
              },
              child: const Text("Play"),
            ),
            ElevatedButton(
              onPressed: () {
                _audioPlayerCubit.resume();
              },
              child: const Text("Resume"),
            ),
            ElevatedButton(
              onPressed: () {
                _audioPlayerCubit.pause();
              },
              child: const Text("Pause"),
            ),
            ElevatedButton(
              onPressed: () {
                _audioPlayerCubit.stop();
              },
              child: const Text("Stop"),
            ),
            ElevatedButton(
              onPressed: () {
                _audioRecordingsCubit.addRecording();
              },
              child: const Text("Add recording"),
            ),
            BlocConsumer<AudioPlayerCubit, AudioPlayerScreenState>(
              listener: (BuildContext context, AudioPlayerScreenState state) {
                // print(state);
              },
              buildWhen: (prevState, state) {
                return state is AudioPlayerScreenInitial;
              },
              builder: (BuildContext context, AudioPlayerScreenState state) {
                switch (state) {
                  case AudioPlayerScreenInitial():
                    return HomeBody(
                      state: state.playerState,
                      totalDuration: state.totalDuration,
                      currentDuration: state.playerPosition,
                    );

                  case AudioPlayerScreenError():
                    throw UnimplementedError();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
