import 'package:whispr/domain/entities/recording_tag.dart';

import 'mood.dart';

class AudioRecording {
  final String name;
  final String? description;
  final String filePath;
  final bool isFavourite;
  final Mood mood;
  final List<RecordingTag> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  AudioRecording({
    required this.name,
    required this.description,
    required this.filePath,
    required this.mood,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    this.isFavourite = false,
  });
}
