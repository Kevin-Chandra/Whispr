import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/audio_recordings/add_or_remove_audio_recording_favourite_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/delete_audio_recording_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/get_favourite_audio_recordings_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteLoadingState()) {
    _getFavourites();
  }

  void _getFavourites() async {
    safeEmit(FavouriteLoadingState());

    final response = await di.get<GetFavouriteAudioRecordingsUseCase>().call();
    response.fold(
      (mappedRecordings) => safeEmit(FavouriteLoadedState(mappedRecordings)),
      (error) => safeEmit(FavouriteErrorState(error)),
    );
    return;
  }

  void refresh() => _getFavourites();

  void addToFavourite(String audioRecordingId) async {
    final response = await di
        .get<AddOrRemoveAudioRecordingFavouriteUseCase>()
        .call(audioRecordingId);
    response.fold((success) {
      safeEmit(FavouriteAddedSuccessState());
    }, (error) {
      safeEmit(FavouriteErrorState(error));
    });
  }

  void deleteAudioRecording(AudioRecording audioRecording) async {
    final response = await di
        .get<DeleteAudioRecordingUseCase>()
        .call(audioRecordingId: audioRecording.id);
    response.fold((success) {
      safeEmit(FavouriteDeleteSuccessState());
    }, (error) {
      safeEmit(FavouriteErrorState(error));
    });
  }
}
