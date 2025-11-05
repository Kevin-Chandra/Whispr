import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_body.dart';
import 'package:whispr/presentation/widgets/whispr_basic_audio_player_with_waveform.dart';

class EditRecordingBodyWrapper extends StatefulWidget {
  const EditRecordingBodyWrapper({
    super.key,
    required this.audioRecording,
    required this.onSaveClicked,
    required this.onMoodSelected,
    required this.onRecordingTagsChanged,
    required this.onCancelClick,
  });

  final AudioRecording audioRecording;
  final Function(String) onSaveClicked;
  final Function(Mood) onMoodSelected;
  final Function(List<RecordingTag>) onRecordingTagsChanged;
  final VoidCallback onCancelClick;

  @override
  State<EditRecordingBodyWrapper> createState() =>
      _EditRecordingBodyWrapperState();
}

class _EditRecordingBodyWrapperState extends State<EditRecordingBodyWrapper> {
  late final AudioPlayerCubit _audioPlayerCubit;
  final TextEditingController _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _audioPlayerCubit = context.read<AudioPlayerCubit>();
    _loadAudioRecording();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerScreenState>(
      builder: (context, audioPlayerScreenState) {
        return LayoutBuilder(
          builder: (ctx, constraint) => SaveAudioRecordingBody(
            isEdit: true,
            waveformWidget: WhisprBasicAudioPlayerWithWaveform(
              audioPlayerScreenState: audioPlayerScreenState,
              waveformData: widget.audioRecording.waveformData,
              waveformWidth: constraint.maxWidth * 0.8,
              onPlayClick: () {
                _audioPlayerCubit.play();
              },
              onPauseClick: () {
                _audioPlayerCubit.pause();
              },
              onErrorRetryClick: () {
                _audioPlayerCubit.prepareAudio(
                  widget.audioRecording.filePath,
                  playImmediately: true,
                );
              },
            ),
            titleController: _titleController,
            titleFormKey: _formKey,
            onCancelClick: widget.onCancelClick,
            onSaveClick: audioPlayerScreenState is AudioPlayerLoadedState
                ? () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    widget.onSaveClicked(_titleController.text);
                  }
                : null,
            selectedMood: widget.audioRecording.mood,
            onMoodSelected: widget.onMoodSelected,
            onRecordingTagChanged: widget.onRecordingTagsChanged,
            selectedRecordingTags: widget.audioRecording.tags,
            createdAt: widget.audioRecording.createdAt,
          ),
        );
      },
    );
  }

  void _loadAudioRecording() {
    _audioPlayerCubit.prepareAudio(
      widget.audioRecording.filePath,
      playImmediately: false,
    );
    _titleController.text = widget.audioRecording.name;
  }
}
