import 'package:flutter/material.dart';
import 'package:whispr/util/extensions.dart';

class RecordAudioBody extends StatefulWidget {
  const RecordAudioBody({
    super.key,
    required this.onRecordClick,
    required this.onOpenMicrophoneAppSettingsClick,
    required this.onPauseClick,
    required this.onResumeClick,
    required this.onStopClick,
    required this.status,
  });

  final VoidCallback onRecordClick;
  final VoidCallback onPauseClick;
  final VoidCallback onResumeClick;
  final VoidCallback onStopClick;
  final VoidCallback onOpenMicrophoneAppSettingsClick;
  final String status;

  @override
  State<RecordAudioBody> createState() => _RecordAudioBodyState();
}

class _RecordAudioBodyState extends State<RecordAudioBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.status),
        ElevatedButton(
          onPressed: widget.onRecordClick,
          child: Text(context.strings.record),
        ),
        ElevatedButton(
          onPressed: widget.onPauseClick,
          child: Text("Pause"),
        ),
        ElevatedButton(
          onPressed: widget.onResumeClick,
          child: Text("Resume"),
        ),
        ElevatedButton(
          onPressed: widget.onStopClick,
          child: Text("Stop"),
        ),
        ElevatedButton(
          onPressed: widget.onOpenMicrophoneAppSettingsClick,
          child: Text("Open app settings"),
        )
      ],
    );
  }
}
