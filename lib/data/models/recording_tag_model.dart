import 'package:hive_ce/hive.dart';

class RecordingTagModel extends HiveObject {
  final String id;
  final String label;

  RecordingTagModel({
    required this.id,
    required this.label,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
    };
  }

  factory RecordingTagModel.fromJson(Map<String, dynamic> json) {
    return RecordingTagModel(
      id: json['id'],
      label: json['label'],
    );
  }
}
