import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/util/uuid_util.dart';

import 'mood.dart';

class AudioRecording {
  final String id;
  final String name;
  final String? description;
  final String filePath;
  final bool isFavourite;
  final Mood mood;
  final List<RecordingTag> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  AudioRecording({
    required this.id,
    required this.name,
    required this.description,
    required this.filePath,
    required this.mood,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    this.isFavourite = false,
  });

  factory AudioRecording.mock() => AudioRecording(
        id: UuidUtil.getRandomUuid(),
        name: "LOL",
        description: "description",
        filePath: "filePath",
        mood: Mood.happy,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
