import 'package:flutter/material.dart';
import 'package:whispr/util/extensions.dart';

class RecordAudioBody extends StatelessWidget {
  const RecordAudioBody({
    super.key,
    required this.onRecordClick,
    required this.onOpenMicrophoneAppSettingsClick,
  });

  final VoidCallback onRecordClick;
  final VoidCallback onOpenMicrophoneAppSettingsClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onRecordClick,
          child: Text(context.strings.record),
        ),
        ElevatedButton(
          onPressed: onOpenMicrophoneAppSettingsClick,
          child: Text("Open app settings"),
        )
      ],
    );
  }
}
