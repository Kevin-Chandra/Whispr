import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/audio_recordings/add_or_remove_audio_recording_favourite_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/delete_audio_recording_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/get_audio_recordings_by_date_use_case.dart';
import 'package:whispr/util/date_time_util.dart';
import 'package:whispr/util/extensions.dart';

part 'journal_state.dart';

class JournalCubit extends Cubit<JournalState> {
  JournalCubit() : super(JournalLoadingState()) {
    getRecordingsByDate(_selectedDate);
  }

  StreamSubscription? _sub;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void refresh() {
    getRecordingsByDate(selectedDate);
  }

  void deleteAudioRecording(AudioRecording audioRecording) async {
    final response = await di
        .get<DeleteAudioRecordingUseCase>()
        .call(audioRecordingId: audioRecording.id);
    response.fold((success) {
      safeEmit(JournalDeleteSuccessState());
    }, (error) {
      safeEmit(JournalErrorState(error));
    });
  }

  void addToFavourite(String audioRecordingId) async {
    final response = await di
        .get<AddOrRemoveAudioRecordingFavouriteUseCase>()
        .call(audioRecordingId);
    response.fold((success) {
      safeEmit(JournalAddToFavouriteSuccessState());
    }, (error) {
      safeEmit(JournalErrorState(error));
    });
  }

  void getRecordingsByDate(DateTime date) async {
    safeEmit(JournalLoadingState());

    // Make sure date selected will not exceed today.=
    if (date.isAfter(DateTimeHelper.getEndOfDay(DateTime.now()))) {
      _selectedDate = DateTime.now();
    } else {
      _selectedDate = date;
    }

    final response = await di.get<GetAudioRecordingsByDateUseCase>().call(date);

    response.fold((recordings) {
      safeEmit(JournalLoadedState(recordings));
    }, (error) {
      safeEmit(JournalErrorState(error));
    });
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
