import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/home/home_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/themes/colors.dart' show WhisprColors;
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_record_button.dart';
import 'package:whispr/util/extensions.dart';

@RoutePage()
class VoiceRecordHomeScreen extends StatefulWidget {
  const VoiceRecordHomeScreen({super.key});

  @override
  State<VoiceRecordHomeScreen> createState() => _VoiceRecordHomeScreenState();
}

class _VoiceRecordHomeScreenState extends State<VoiceRecordHomeScreen> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    context.strings.shareYourThoughts,
                    style: WhisprTextStyles.heading3
                        .copyWith(color: WhisprColors.spanishViolet),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: WhisprRecordButton(
              onClick: () async {
                // Stop any playing audio before recording.
                _homeCubit.stopPlayingAudio();

                final result =
                    await NavigationCoordinator.navigateToRecordAudio(
                  context: context,
                  startImmediately: true,
                );

                if (context.mounted && result == true) {
                  _homeCubit.refreshAudioRecordings();
                  NavigationCoordinator.navigateToJournalTab(context: context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
