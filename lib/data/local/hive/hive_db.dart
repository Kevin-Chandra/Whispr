import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/hive/hive_adapter/hive_registrar.g.dart';
import 'package:whispr/data/local/hive/whispr_hive_db_keys.dart';

@singleton
class HiveLocalStorage {
  HiveLocalStorage(this._secureStorage);

  late Box<String> hiveBox;
  final FlutterSecureStorage _secureStorage;

  Future<HiveLocalStorage> init() async {
    Hive
      ..init(Directory.current.path)
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
      await Hive.deleteBoxFromDisk(WhisprHiveDbKeys.hiveDbKey);
      // We store the new encryption key into the secure storage [keychain/Keystore].
      _secureStorage.write(
        key: WhisprHiveDbKeys.hiveBoxKey,
        value: base64UrlEncode(newKey),
      );
      // We open the HIVE box using new encryption key.
      await _openHiveDbBox(
        WhisprHiveDbKeys.hiveDbKey,
        base64Url.decode(
          (await _secureStorage.read(key: WhisprHiveDbKeys.hiveBoxKey))!,
        ),
      );
    } else {
      // If we find an existing encryption key, we simply open the HIVE box with the existing key.
      final key = base64Url.decode(secureKey);
      await _openHiveDbBox(WhisprHiveDbKeys.hiveDbKey, key);
    }
    return this;
  }

  /// Method to open an encrypted HIVE box using its [name] and the encryption key [key].
  Future<void> _openHiveDbBox(String dbname, Uint8List key) async {
    hiveBox = await Hive.openBox(dbname, encryptionCipher: HiveAesCipher(key));
  }

  Future<Box<T>> getBox<T>(String boxKey) async {
    return await Hive.openBox(boxKey);
  }
}
