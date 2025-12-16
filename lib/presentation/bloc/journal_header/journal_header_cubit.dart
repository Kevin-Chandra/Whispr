import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/audio_recordings/get_audio_recording_dates_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'journal_header_state.dart';

class JournalHeaderCubit extends Cubit<JournalHeaderState> {
  JournalHeaderCubit() : super(JournalHeaderLoadingState()) {
    getRecordingDates();
  }

  void refresh() {
    getRecordingDates();
  }

  void getRecordingDates() async {
    final response = await di.get<GetAudioRecordingDatesUseCase>().call();
    final fallbackMinDate = DateTime.now().subtract(Duration(days: 30));

    response.fold((dates) {
      dates.sort((a, b) => a.compareTo(b));
      safeEmit(JournalHeaderLoadedState(
          dates, dates.firstOrNull ?? fallbackMinDate));
    }, (error) {
      safeEmit(JournalHeaderErrorState(error));
    });
  }
}
