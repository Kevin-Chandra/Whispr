import 'package:dartz/dartz.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/recording_tag.dart';

abstract class RecordingTagRepository {
  Future<Either<bool, FailureEntity>> saveRecordingTag(
      RecordingTag recordingTag);

  Future<Either<bool, FailureEntity>> deleteRecordingTag(String id);

  Stream<List<RecordingTag>> getAllRecordingTags();
}
