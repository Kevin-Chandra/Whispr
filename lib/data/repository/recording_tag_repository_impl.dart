import 'package:dartz/dartz.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:listenable_stream/listenable_stream.dart';
import 'package:whispr/data/mappers/recording_tag_mapper.dart';
import 'package:whispr/data/models/recording_tag_model.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/domain/repository/recording_tag_repository.dart';

@Injectable(as: RecordingTagRepository)
class RecordingTagRepositoryImpl implements RecordingTagRepository {
  RecordingTagRepositoryImpl(this._box);

  final Box<RecordingTagModel> _box;

  @override
  Future<Either<bool, FailureEntity>> deleteRecordingTag(String id) async {
    await _box.delete(id);
    return left(true);
  }

  @override
  Stream<List<RecordingTag>> getAllRecordingTags() {
    return _box
        .listenable()
        .toValueStream(replayValue: true)
        .map((box) => box.values.toList())
        .map((list) => list.map((model) => model.mapToDomain()).toList());
  }

  @override
  Future<Either<bool, FailureEntity>> saveRecordingTag(
      RecordingTag recordingTag) async {
    await _box.put(recordingTag.id, recordingTag.mapToModel());
    return left(true);
  }
}
