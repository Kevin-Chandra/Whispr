import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FlutterSecureStorage> get secureStorage async =>
      const FlutterSecureStorage();

  @preResolve
  Future<PackageInfo> get packageInfo async => await PackageInfo.fromPlatform();
}
