import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/di/di_config.config.dart';

@InjectableInit()
Future<GetIt> configureDependencies() async => di.init();

final di = GetIt.instance;
