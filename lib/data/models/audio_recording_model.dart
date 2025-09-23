import 'package:hive_ce/hive.dart';
import 'package:whispr/data/models/recording_tag_model.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/util/date_time_util.dart';

class AudioRecordingModel extends HiveObject {
  final String id;
  final String name;
  final String? description;
  final String filePath;
  final bool isFavourite;
  final Mood mood;
  final List<RecordingTagModel> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  AudioRecordingModel({
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

  factory AudioRecordingModel.fromJson(Map<String, dynamic> json) =>
      AudioRecordingModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        filePath: json['filePath'],
        mood: Mood.values.byName(json['mood']),
        tags: List<RecordingTagModel>.from(
            json['tags'].map((x) => RecordingTagModel.fromJson(x))),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'filePath': filePath,
      'isFavourite': isFavourite,
      'mood': mood.name, // store enum as string
      'tags': tags.map((tag) => tag.toJson()).toList(),
      'createdAt': createdAt.formattedJsonTime,
      'updatedAt': updatedAt.formattedJsonTime,
    };
  }
}
