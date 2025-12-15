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

  Future<void> clearDatabase() async {
    await audioRecordingBox.clear();
    await createdDateIndexBox.clear();
    await isFavouriteIndexBox.clear();
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

  Future<List<AudioRecordingModel>> getRecordByDateRange({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final ids = await _getIdByDateRange(
      startDate: startDate,
      endDate: endDate,
    );

    if (ids.isEmpty) {
      return [];
    }

    return ids.map((id) => audioRecordingBox.get(id)).nonNulls.toList();
  }

  Future<int> getRecordCountByDateRange({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return (await _getIdByDateRange()).length;
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

  Future<void> bulkInsert(List<AudioRecordingModel> audioRecordings) async {
    await Future.wait(
        audioRecordings.map((recording) => createRecord(recording)));
  }

  Future<(DateTime, DateTime)?> getRecordingFirstAndLastDate() async {
    final dateIndexList =
        createdDateIndexBox.keys.map((key) => key.toString()).toList();

    // No recording found, return null.
    if (dateIndexList.isEmpty) {
      return null;
    }

    dateIndexList.sort((a, b) => a.compareTo(b));
    final firstDate = DateTime.parse(dateIndexList.first.trim());
    final lastDate = DateTime.parse(dateIndexList.last.trim());

    return (firstDate, lastDate);
  }

  Future<List<DateTime>> getRecordingDates() async {
    final dateIndexList =
        createdDateIndexBox.keys.map((key) => key.toString()).toList();

    return dateIndexList.map((date) => DateTime.parse(date.trim())).toList();
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

  Future<List<String>> _getIdByDateRange({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final dateIndexList =
        createdDateIndexBox.keys.map((key) => key.toString()).toList();
    dateIndexList.sort((a, b) => a.compareTo(b));
    final dateIndexLength = dateIndexList.length;

    final startIndex = startDate == null
        ? 0
        : _lowerBound(dateIndexList, _indexKeyOfDateObject(startDate));
    final endIndex = endDate == null
        ? dateIndexLength
        : _upperBound(dateIndexList, _indexKeyOfDateObject(endDate));

    final selectedDates = dateIndexList.sublist(startIndex, endIndex);
    return selectedDates
        .map((date) => createdDateIndexBox.get(date))
        .nonNulls
        .expand((set) => set)
        .toSet()
        .toList();
  }

  int _lowerBound(List<String> sortedList, String target) {
    int low = 0;
    int high = sortedList.length;
    while (low < high) {
      int mid = (low + high) ~/ 2;
      if (sortedList[mid].compareTo(target) < 0) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }
    return low;
  }

  int _upperBound(List<String> sortedList, String target) {
    int low = 0;
    int high = sortedList.length;
    while (low < high) {
      int mid = (low + high) ~/ 2;
      if (sortedList[mid].compareTo(target) <= 0) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }
    return low;
  }

//endregion
}
