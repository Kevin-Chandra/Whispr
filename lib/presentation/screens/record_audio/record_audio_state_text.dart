import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/util/extensions.dart';

class RecordAudioStateText extends StatelessWidget {
  const RecordAudioStateText({super.key, required this.isRecording});

  final bool isRecording;

  @override
  Widget build(BuildContext context) {
    return Text(
      isRecording
          ? context.strings.recording
          : context.strings.paused,
      style: WhisprTextStyles.heading3
          .copyWith(color: WhisprColors.spanishViolet),
    );
  }
}
