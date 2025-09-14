import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/util/extensions.dart';

@RoutePage()
class SaveAudioRecordingScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const SaveAudioRecordingScreen({
    super.key,
    @PathParam() required this.audioRecordingPath,
  });

  final String audioRecordingPath;

  @override
  State<SaveAudioRecordingScreen> createState() =>
      _SaveAudioRecordingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioPlayerCubit>(create: (context) => AudioPlayerCubit()),
      ],
      child: this,
    );
  }
}

class _SaveAudioRecordingScreenState extends State<SaveAudioRecordingScreen> {
  late PlayerController playerController;
  List<double> waveformData = [];

  @override
  void initState() {
    super.initState();
    playerController = PlayerController();
    a();
  }

  void a() async {
    waveformData = await playerController.extractWaveformData(
        path: widget.audioRecordingPath);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WhisprGradientScaffold(
        gradient: WhisprGradient.whiteBlueWhiteGradient,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              WhisprAppBar(
                title: context.strings.voice_record,
                isDarkBackground: false,
              )
            ];
          },
          body: Column(
            children: [
              AudioFileWaveforms(
                size: Size(300, 100),
                playerController: playerController,
                waveformData: waveformData,
                waveformType: WaveformType.fitWidth,
                playerWaveStyle: PlayerWaveStyle(
                  fixedWaveColor: Color(0xFFEAE6FF),
                  liveWaveColor: Color(0xFF9FA8FF),
                  seekLineThickness: 0,
                  // hide center line
                  waveCap: StrokeCap.round,
                  showTop: true,
                  showBottom: true,
                  // controls bar height
                  spacing: 3,
                  scaleFactor: 500,
                  // distance between bars
                  waveThickness: 1,
                ),
              ),
              Text(widget.audioRecordingPath),
            ],
          ),
        ));
  }
}
