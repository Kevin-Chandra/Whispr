import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/domain/repository/recording_tag_repository.dart';
import 'package:whispr/util/extensions.dart';
import 'package:whispr/util/uuid_util.dart';

@injectable
class SaveRecordingTagUseCase {
  SaveRecordingTagUseCase(this._recordingTagRepository);

  final RecordingTagRepository _recordingTagRepository;

  Future<Either<RecordingTag, FailureEntity>> call(String label) async {
    if (label.isNullOrEmpty) {
      return right(FailureEntity(error: "Label is empty"));
    }

    final doesTagExist = await _recordingTagRepository.getTagByLabel(label);
    return doesTagExist.fold((tag) {
      if (tag != null) {
        return left(tag);
      }

      final recordingTag = RecordingTag(
        id: UuidUtil.getRandomUuid(),
        label: label,
      );

      _recordingTagRepository.saveRecordingTag(recordingTag);
      return left(recordingTag);
    }, (error) {
      return right(error);
    });
  }
}
