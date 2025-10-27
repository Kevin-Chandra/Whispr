import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:listenable_stream/listenable_stream.dart';
import 'package:whispr/data/local/hive/whispr_hive_db_keys.dart';
import 'package:whispr/data/models/audio_recording_model.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/date_time_util.dart';

@injectable
class AudioRecordingLocalIndexableDatabase {
  const AudioRecordingLocalIndexableDatabase(
    @Named(WhisprHiveDbKeys.audioRecordingBoxKey) this.audioRecordingBox,
    @Named(WhisprHiveDbKeys.audioRecordingDateIndexBoxKey)
    this.createdDateIndexBox,
    @Named(WhisprHiveDbKeys.audioRecordingIsFavouriteIndexBoxKey)
    this.isFavouriteIndexBox,
  );

  final Box<AudioRecordingModel> audioRecordingBox;
  final Box<Set<String>> createdDateIndexBox;
  final Box<Set<String>> isFavouriteIndexBox;

  Future<bool> createRecord(AudioRecordingModel audioRecording) async {
    await audioRecordingBox.put(audioRecording.id, audioRecording);
    await _addToIndexes(audioRecording);
    return true;
  }

  Future<bool> updateRecord(AudioRecordingModel audioRecording) async {
    final old = audioRecordingBox.get(audioRecording.id);
    // Object not found, return.
    if (old == null) {
      return false;
    }

    // Update audio recording.
    await audioRecordingBox.put(audioRecording.id, audioRecording);

    // Update indexes.
    await _removeFromIndexes(old);
    await _addToIndexes(audioRecording);
    return true;
  }

  Future<bool> deleteRecord(String objectId) async {
    final currentObject = audioRecordingBox.get(objectId);
    // Object not found, return.
    if (currentObject == null) {
      return false;
    }

    await audioRecordingBox.delete(objectId);
    await _removeFromIndexes(currentObject);
    return true;
  }

  Future<AudioRecordingModel?> getAudioRecording(String objectId) async {
    return audioRecordingBox.get(objectId);
  }

  List<AudioRecordingModel> getAllRecord() {
    return audioRecordingBox.values.toList();
  }

  List<AudioRecordingModel> getRecordByDate(DateTime indexObject) {
    final indexKey = _indexKeyOfDateObject(indexObject);
    final ids = createdDateIndexBox.get(indexKey);
    if (ids == null || ids.isEmpty) {
      return [];
    }

    return ids
        .map((id) => audioRecordingBox.get(id))
        .whereType<AudioRecordingModel>()
        .toList();
  }

  List<AudioRecordingModel> getRecordByBoolean(bool booleanObject) {
    final indexKey = booleanObject.toString();
    final ids = isFavouriteIndexBox.get(indexKey);
    if (ids == null || ids.isEmpty) {
      return [];
    }

    return ids
        .map((id) => audioRecordingBox.get(id))
        .whereType<AudioRecordingModel>()
        .toList();
  }

  Stream<Iterable<AudioRecordingModel>> watchRecordings() {
    return audioRecordingBox
        .listenable()
        .toValueStream(replayValue: true)
        .map((box) => box.values);
  }

  //region Private methods.

  // Method to add object to indexes.
  Future<void> _addToIndexes(AudioRecordingModel audioRecording) async {
    await _addToFavouriteIndex(
        audioRecording.isFavourite.toString(), audioRecording.id);
    await _addToDateIndex(audioRecording.createdAt, audioRecording.id);
  }

  Future<void> _addToFavouriteIndex(
    String isFavouriteIndexKey,
    String objectId,
  ) async {
    final current = isFavouriteIndexBox.get(isFavouriteIndexKey) ?? {};
    if (!current.contains(objectId)) {
      final updated = Set<String>.from(current)..add(objectId);
      await isFavouriteIndexBox.put(isFavouriteIndexKey, updated);
    }
  }

  Future<void> _addToDateIndex(DateTime dateIndexKey, String objectId) async {
    final indexKey = _indexKeyOfDateObject(dateIndexKey);
    final current = createdDateIndexBox.get(indexKey) ?? {};
    if (!current.contains(objectId)) {
      final updated = Set<String>.from(current)..add(objectId);
      await createdDateIndexBox.put(indexKey, updated);
    }
  }

  // Remove index methods

  Future<void> _removeFromIndexes(AudioRecordingModel audioRecording) async {
    await _removeFromFavouriteIndex(
        audioRecording.isFavourite.toString(), audioRecording.id);
    await _removeFromDateIndex(audioRecording.createdAt, audioRecording.id);
  }

  Future<void> _removeFromFavouriteIndex(
    String isFavouriteIndexKey,
    String objectId,
  ) async {
    final current = isFavouriteIndexBox.get(isFavouriteIndexKey);
    if (current == null) {
      return;
    }

    final updatedList = Set<String>.from(current)..remove(objectId);
    if (updatedList.isEmpty) {
      await isFavouriteIndexBox.delete(isFavouriteIndexKey);
    } else {
      await isFavouriteIndexBox.put(isFavouriteIndexKey, updatedList);
    }
  }

  Future<void> _removeFromDateIndex(
      DateTime dateIndexKey, String objectId) async {
    final indexKey = _indexKeyOfDateObject(dateIndexKey);
    final current = createdDateIndexBox.get(indexKey);
    if (current == null) {
      return;
    }

    final updatedList = Set<String>.from(current)..remove(objectId);
    if (updatedList.isEmpty) {
      await createdDateIndexBox.delete(indexKey);
    } else {
      await createdDateIndexBox.put(indexKey, updatedList);
    }
  }

  String _indexKeyOfDateObject(DateTime dateTime) {
    return DateTimeHelper.formatDateTime(
      dateTime,
      DateFormatConstants.dateIndexFormat,
    );
  }

//endregion
}
