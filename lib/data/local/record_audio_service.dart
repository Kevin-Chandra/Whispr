import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:whispr/data/local/record_audio_exception.dart';
import 'package:whispr/data/models/service_failure_model.dart';

@injectable
class RecordAudioService {
  late AudioRecorder? _audioRecorder;

  Future<Either<void, ServiceFailureModel>> init() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      return left(null);
    }

    if (status.isDenied) {
      return right(ServiceFailureModel.empty(
          serviceException: MicrophonePermissionDenied()));
    }

    if (status.isPermanentlyDenied) {
      return right(ServiceFailureModel.empty(
          serviceException: MicrophonePermissionDeniedForever()));
    }

    return left(null);
  }

  void openAppPermissionSettings() async => await openAppSettings();

// Future<Either<bool, ServiceFailureModel>> startRecord() async {
//   _audioRecorder = AudioRecorder();
//
//   final config = RecordConfig()
//
//   await _audioRecorder?.start(config, path: )
//
//   println('started')
// }
}
