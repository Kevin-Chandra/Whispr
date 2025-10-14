import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/audio_recordings/get_audio_recording_by_id_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/update_audio_recording_use_case.dart';

@injectable
class AddOrRemoveAudioRecordingFavouriteUseCase {
  AddOrRemoveAudioRecordingFavouriteUseCase(
      this._updateAudioRecordingUseCase, this._getAudioRecordingByIdUseCase);

  final UpdateAudioRecordingUseCase _updateAudioRecordingUseCase;
  final GetAudioRecordingByIdUseCase _getAudioRecordingByIdUseCase;

  Future<Either<bool, FailureEntity>> call(String audioRecordingId) async {
    final response = await _getAudioRecordingByIdUseCase(audioRecordingId);
    return response.fold((audioRecording) {
      return _updateAudioRecordingUseCase.call(
        currentAudioRecording: audioRecording,
        isFavourite: !audioRecording.isFavourite,
      );
    }, (error) => right(error));
  }
}
