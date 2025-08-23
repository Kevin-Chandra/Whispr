import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/record_audio/request_microphone_access_use_case.dart';
import 'package:whispr/presentation/bloc/record_audio/record_audio_state.dart';
import 'package:whispr/util/extensions.dart';

class RecordAudioCubit extends Cubit<RecordAudioState> {
  RecordAudioCubit() : super(RecordAudioInitialState());

  Future<void> recordAudio() async {
    safeEmit(RecordAudioLoadingState());

    final response = await di.get<RequestMicrophoneAccessUseCase>().call();
    if (response.isRight()) {
      safeEmit(RecordAudioErrorState(
          error: response.getOrElse(FailureEntity.empty)));
    }

    safeEmit(RecordingAudioState());
  }

  void resetState() {
    safeEmit(RecordAudioInitialState());
  }
}
