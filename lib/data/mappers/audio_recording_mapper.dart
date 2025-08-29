import 'package:whispr/data/mappers/recording_tag_mapper.dart';
import 'package:whispr/data/models/audio_recording_model.dart';
import 'package:whispr/domain/entities/audio_recording.dart';

extension AudioRecordingModelMapper on AudioRecordingModel {
  AudioRecording mapToDomain() =>
      AudioRecording(
        name: name,
        description: description,
        filePath: filePath,
        mood: mood,
        tags: tags.map((x) => x.mapToDomain()).toList(),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension AudioRecordingMapper on AudioRecording {
  AudioRecordingModel mapToModel() =>
      AudioRecordingModel(
        name: name,
        description: description,
        filePath: filePath,
        mood: mood,
        tags: tags.map((x) => x.mapToModel()).toList(),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
