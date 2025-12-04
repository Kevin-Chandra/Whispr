import 'package:dartz/dartz.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:listenable_stream/listenable_stream.dart';
import 'package:whispr/data/local/hive/whispr_hive_db_keys.dart';
import 'package:whispr/data/mappers/recording_tag_mapper.dart';
import 'package:whispr/data/models/recording_tag_model.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/domain/repository/recording_tag_repository.dart';
import 'package:whispr/util/extensions.dart';

@Injectable(as: RecordingTagRepository)
class RecordingTagRepositoryImpl implements RecordingTagRepository {
  RecordingTagRepositoryImpl(
    @Named(WhisprHiveDbKeys.recordingTagBoxKey) this._box,
  );

  final Box<RecordingTagModel> _box;

  @override
  Future<Either<bool, FailureEntity>> deleteRecordingTag(String id) async {
    await _box.delete(id);
    return left(true);
  }

  @override
  Stream<List<RecordingTag>> getRecordingTagStream() {
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

  @override
  Future<Either<List<RecordingTag>, FailureEntity>> getAllRecordingTag(
      {String? label}) async {
    final tags = _box.values.where(
        (tag) => label.isNullOrEmpty ? true : tag.label.contains(label!));

    return left(tags.map((tag) => tag.mapToDomain()).toList());
  }

  @override
  Future<Either<RecordingTag?, FailureEntity>> getTagByLabel(
      String label) async {
    final tag = _box.values
        .firstWhereOrNull((tag) => tag.label.equalsIgnoreCase(label));
    return left(tag?.mapToDomain());
  }

  @override
  Future<Either<bool, FailureEntity>> clearAllTags() async {
    try {
      await _box.clear();
      return left(true);
    } on Exception catch (e, s) {
      return right(FailureEntity(error: e.toString()));
    }
  }
}
