import 'package:dartz/dartz.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class AudioRecordingRepository {
  Future<Either<bool, FailureEntity>> saveAudioRecording(
      AudioRecording audioRecording);

  Future<Either<bool, FailureEntity>> updateAudioRecording(
      AudioRecording audioRecording);

  Future<Either<bool, FailureEntity>> deleteAudioRecording(String id);

  Future<Either<bool, FailureEntity>> deleteAudioRecordingFile(String filePath);

  Future<Either<List<AudioRecording>, FailureEntity>> getRecordingsByDate(
      DateTime date);

  Future<Either<List<AudioRecording>, FailureEntity>> getRecordingsByFavourite(
      bool isFavourite);

  Stream<List<AudioRecording>> getAllRecordings();

  Future<Either<AudioRecording, FailureEntity>> getAudioRecordingById(
      String id);

  Future<(DateTime, DateTime)?> getRecordingFirstAndLastDate();
}
