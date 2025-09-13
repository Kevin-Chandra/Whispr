import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_elevated_icon_button.dart';
import 'package:whispr/util/extensions.dart';

class RecordAudioBody extends StatefulWidget {
  const RecordAudioBody({
    super.key,
    required this.onSaveClick,
    required this.onPauseClick,
    required this.onResumeClick,
    required this.onCancelClick,
    required this.isRecording,
  });

  final VoidCallback onSaveClick;
  final VoidCallback onPauseClick;
  final VoidCallback onResumeClick;
  final VoidCallback onCancelClick;
  final bool isRecording;

  @override
  State<RecordAudioBody> createState() => _RecordAudioBodyState();
}

class _RecordAudioBodyState extends State<RecordAudioBody> {
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
                    widget.isRecording
                        ? context.strings.recording
                        : context.strings.paused,
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
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.isRecording
                      ? WhisprElevatedIconButton(
                          onClick: widget.onPauseClick,
                          icon: Icons.pause_rounded,
                          buttonSize: ButtonSize.xLarge,
                        )
                      : WhisprElevatedIconButton(
                          onClick: widget.onResumeClick,
                          icon: Icons.play_arrow_rounded,
                          buttonSize: ButtonSize.xLarge,
                        ),
                  WhisprElevatedIconButton(
                    onClick: widget.onSaveClick,
                    icon: Icons.check_rounded,
                    buttonSize: ButtonSize.xxLarge,
                  ),
                  WhisprElevatedIconButton(
                    onClick: widget.onCancelClick,
                    icon: Icons.close_rounded,
                    buttonSize: ButtonSize.xLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ],
    );
  }
}
