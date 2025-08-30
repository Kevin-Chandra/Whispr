import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/domain/repository/recording_tag_repository.dart';

@injectable
class SaveRecordingTagUseCase {
  SaveRecordingTagUseCase(this._recordingTagRepository);

  final RecordingTagRepository _recordingTagRepository;

  Stream<List<RecordingTag>> call() {
    return _recordingTagRepository.getAllRecordingTags();
  }
}
