import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/use_case/archive/get_recording_count_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'recording_count_state.dart';

class RecordingCountCubit extends Cubit<RecordingCountState> {
  RecordingCountCubit() : super(RecordingCountLoading());

  Future<void> calculateCount(DateTime start, DateTime end) async {
    safeEmit(RecordingCountLoading());

    final count = await di
        .get<GetRecordingCountUseCase>()
        .call(startDate: start, endDate: end);

    safeEmit(RecordingCountLoaded(count));
  }
}
