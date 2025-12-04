import 'package:hive_ce/hive.dart';
import 'package:whispr/data/models/recording_tag_model.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/util/date_time_util.dart';

class AudioRecordingModel extends HiveObject {
  final String id;
  final String name;
  final String filePath;
  final bool isFavourite;
  final Mood mood;
  final List<RecordingTagModel> tags;
  final List<double>? waveformData;
  final Duration duration;
  final DateTime createdAt;
  final DateTime updatedAt;

  AudioRecordingModel({
    required this.id,
    required this.name,
    required this.filePath,
    required this.mood,
    required this.tags,
    required this.isFavourite,
    required this.waveformData,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  AudioRecordingModel copyWith({
    String? id,
    String? name,
    String? filePath,
    bool? isFavourite,
    Mood? mood,
    List<RecordingTagModel>? tags,
    List<double>? waveformData,
    Duration? duration,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AudioRecordingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      filePath: filePath ?? this.filePath,
      isFavourite: isFavourite ?? this.isFavourite,
      mood: mood ?? this.mood,
      tags: tags ?? List<RecordingTagModel>.from(this.tags),
      waveformData: waveformData ?? this.waveformData,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory AudioRecordingModel.fromJson(Map<String, dynamic> json) =>
      AudioRecordingModel(
        id: json['id'],
        name: json['name'],
        filePath: json['filePath'],
        mood: Mood.values.byName(json['mood']),
        tags: List<RecordingTagModel>.from(
            json['tags'].map((x) => RecordingTagModel.fromJson(x))),
        isFavourite: json['isFavourite'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        waveformData: List<double>.from(json['waveformData']),
        duration: Duration(milliseconds: json['duration']),
      );

  static List<AudioRecordingModel> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => AudioRecordingModel.fromJson(json)).toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'filePath': filePath,
      'isFavourite': isFavourite,
      'mood': mood.name, // store enum as string
      'tags': tags.map((tag) => tag.toJson()).toList(),
      'waveformData': waveformData,
      'duration': duration.inMilliseconds,
      'createdAt': createdAt.formattedJsonTime,
      'updatedAt': updatedAt.formattedJsonTime,
    };
  }
}
