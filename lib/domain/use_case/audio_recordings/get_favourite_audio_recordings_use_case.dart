import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';
import 'package:whispr/util/date_time_util.dart';

@injectable
class GetFavouriteAudioRecordingsUseCase {
  GetFavouriteAudioRecordingsUseCase(this._audioRecordingRepository);

  final AudioRecordingRepository _audioRecordingRepository;

  Future<Either<Map<DateTime, List<AudioRecording>>, FailureEntity>> call({
    bool descendingOrder = true,
  }) async {
    final response =
        await _audioRecordingRepository.getRecordingsByFavourite(true);

    return response.fold(
      (recordings) {
        recordings.sort((a, b) => descendingOrder
            ? b.createdAt.compareTo(a.createdAt)
            : a.createdAt.compareTo(b.createdAt));

        final mappedRecordings = <DateTime, List<AudioRecording>>{};
        for (final recording in recordings) {
          final date = recording.createdAt.extractDate;
          final datedRecordings = mappedRecordings[date];
          if (datedRecordings == null) {
            mappedRecordings[date] = [recording];
          } else {
            final newList = List<AudioRecording>.from(datedRecordings)
              ..add(recording);
            mappedRecordings[date] = newList;
          }
        }
        return left(mappedRecordings);
      },
      (error) => right(error),
    );
  }
}
