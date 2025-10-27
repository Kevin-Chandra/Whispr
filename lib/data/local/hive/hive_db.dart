import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/file_service.dart';
import 'package:whispr/data/local/hive/hive_adapter/hive_registrar.g.dart';
import 'package:whispr/data/local/hive/whispr_hive_db_keys.dart';
import 'package:whispr/data/models/audio_recording_model.dart';
import 'package:whispr/data/models/recording_tag_model.dart';
import 'package:whispr/di/di_config.dart';

@singleton
class HiveLocalStorage {
  HiveLocalStorage(this._secureStorage, this._fileService);

  final FlutterSecureStorage _secureStorage;
  final FileService _fileService;
  late Box<String> hiveBox;

  Future<HiveLocalStorage> init() async {
    final defaultDirectory = await _fileService.getDefaultDirectory();

    Hive
      ..init(defaultDirectory)
      ..registerAdapters();

    // We try to fetch an existing encryption key from the [keychain] or [Keystore].
    final secureKey =
        await _secureStorage.read(key: WhisprHiveDbKeys.hiveBoxKey) ?? '';

    if (secureKey.isEmpty) {
      // If we do not find any encryption key, we generate a new key.
      final newKey = Hive.generateSecureKey();
      // We nuke any existing app data from the secure storage [keychain/Keystore].
      _secureStorage.deleteAll();
      // We nuke all data from the database.
      await _nukeDatabase();
      // We store the new encryption key into the secure storage [keychain/Keystore].
      _secureStorage.write(
        key: WhisprHiveDbKeys.hiveBoxKey,
        value: base64UrlEncode(newKey),
      );
      // We open the HIVE box using new encryption key.
      await _openHiveDbBox(
        base64Url.decode(
          (await _secureStorage.read(key: WhisprHiveDbKeys.hiveBoxKey))!,
        ),
      );
    } else {
      // If we find an existing encryption key, we simply open the HIVE box with the existing key.
      final key = base64Url.decode(secureKey);
      await _openHiveDbBox(key);
    }
    return this;
  }

  /// Method to open all encrypted HIVE boxes using encryption key [key]
  /// and register it in dependency injection.
  Future<void> _openHiveDbBox(Uint8List key) async {
    await _openAndRegisterBox<String>(
      WhisprHiveDbKeys.settingsBoxKey,
      key,
    );
    await _openAndRegisterBox<AudioRecordingModel>(
      WhisprHiveDbKeys.audioRecordingBoxKey,
      key,
    );
    await _openAndRegisterBox<Set<String>>(
      WhisprHiveDbKeys.audioRecordingDateIndexBoxKey,
      key,
    );
    await _openAndRegisterBox<Set<String>>(
      WhisprHiveDbKeys.audioRecordingIsFavouriteIndexBoxKey,
      key,
    );
    await _openAndRegisterBox<RecordingTagModel>(
      WhisprHiveDbKeys.recordingTagBoxKey,
      key,
    );
  }

  /// Method to remove all boxes registered in hive database.
  Future<void> _nukeDatabase() async {
    await Hive.deleteBoxFromDisk(WhisprHiveDbKeys.audioRecordingBoxKey);
    await Hive.deleteBoxFromDisk(
        WhisprHiveDbKeys.audioRecordingDateIndexBoxKey);
    await Hive.deleteBoxFromDisk(
        WhisprHiveDbKeys.audioRecordingIsFavouriteIndexBoxKey);
    await Hive.deleteBoxFromDisk(WhisprHiveDbKeys.recordingTagBoxKey);
    await Hive.deleteBoxFromDisk(WhisprHiveDbKeys.settingsBoxKey);
  }

  Future<void> _openAndRegisterBox<T>(
    String boxKey,
    List<int> encryptionKey,
  ) async {
    final box = await Hive.openBox<T>(
      boxKey,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    di.registerLazySingleton<Box<T>>(() => box, instanceName: boxKey);
  }
}
