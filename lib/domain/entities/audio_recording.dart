import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/util/uuid_util.dart';

import 'mood.dart';

class AudioRecording {
  final String id;
  final String name;
  final String filePath;
  final bool isFavourite;
  final Mood mood;
  final List<RecordingTag> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  AudioRecording({
    required this.id,
    required this.name,
    required this.filePath,
    required this.mood,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    this.isFavourite = false,
  });

  AudioRecording copyWith({
    String? name,
    String? filePath,
    bool? isFavourite,
    Mood? mood,
    List<RecordingTag>? tags,
    DateTime? updatedAt,
  }) {
    return AudioRecording(
      id: id,
      name: name ?? this.name,
      filePath: this.filePath,
      isFavourite: isFavourite ?? this.isFavourite,
      mood: mood ?? this.mood,
      tags: tags ?? List.from(this.tags),
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory AudioRecording.mock() => AudioRecording(
        id: UuidUtil.getRandomUuid(),
        name: "LOL",
        filePath: "filePath",
        mood: Mood.happy,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
