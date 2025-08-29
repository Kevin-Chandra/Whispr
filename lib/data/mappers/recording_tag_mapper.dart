import 'package:whispr/data/models/recording_tag_model.dart';
import 'package:whispr/domain/entities/recording_tag.dart';

extension RecordingTagModelMapper on RecordingTagModel {
  RecordingTag mapToDomain() => RecordingTag(
        id: id,
        label: label,
      );
}

extension RecordingTagMapper on RecordingTag {
  RecordingTagModel mapToModel() => RecordingTagModel(
        id: id,
        label: label,
      );
}
