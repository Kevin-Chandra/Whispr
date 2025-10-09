import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/domain/repository/recording_tag_repository.dart';

@injectable
class GetAllRecordingTagsUseCase {
  GetAllRecordingTagsUseCase(this._recordingTagRepository);

  final RecordingTagRepository _recordingTagRepository;

  Future<Either<List<RecordingTag>, FailureEntity>> call({String? label}) {
    return _recordingTagRepository.getAllRecordingTag(label: label);
  }
}
