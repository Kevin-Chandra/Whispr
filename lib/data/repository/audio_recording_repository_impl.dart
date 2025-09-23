import 'package:dartz/dartz.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:listenable_stream/listenable_stream.dart';
import 'package:whispr/data/mappers/audio_recording_mapper.dart';
import 'package:whispr/data/models/audio_recording_model.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';

@Injectable(as: AudioRecordingRepository)
class AudioRecordingRepositoryImpl implements AudioRecordingRepository {
  AudioRecordingRepositoryImpl(this._box);

  final Box<AudioRecordingModel> _box;

  @override
  Future<Either<bool, FailureEntity>> saveAudioRecording(
    AudioRecording audioRecording,
  ) async {
    await _box.put(audioRecording.id, audioRecording.mapToModel());
    return left(true);
  }

  @override
  Future<Either<bool, FailureEntity>> deleteAudioRecording(String id) async {
    await _box.delete(id);
    return left(true);
  }

  @override
  Stream<List<AudioRecording>> getAllRecordings() {
    return _box
        .listenable()
        .toValueStream(replayValue: true)
        .map((box) => box.values.toList())
        .map((list) => list.map((model) => model.mapToDomain()).toList());
  }
}
