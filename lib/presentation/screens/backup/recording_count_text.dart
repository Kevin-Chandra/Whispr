import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/presentation/bloc/recording_count/recording_count_cubit.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

class RecordingCountText extends StatefulWidget {
  const RecordingCountText({super.key});

  @override
  State<RecordingCountText> createState() => _RecordingCountTextState();
}

class _RecordingCountTextState extends State<RecordingCountText> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingCountCubit, RecordingCountState>(
        builder: (context, state) {
      return AnimatedSwitcher(
          duration: const Duration(
            milliseconds: WhisprDuration.stateFadeTransitionMillis,
          ),
          child: switch (state) {
            RecordingCountLoading() => Skeletonizer(
                child: Text(context.strings.recordingCount(100)),
              ),
            RecordingCountLoaded() => Text(
                context.strings.recordingCount(state.count),
                style: WhisprTextStyles.bodyS
                    .copyWith(color: WhisprColors.vistaBlue),
              ),
          });
    });
  }
}
