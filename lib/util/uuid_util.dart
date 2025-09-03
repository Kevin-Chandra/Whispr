import 'package:uuid/v4.dart';

abstract class UuidUtil {
  static String getRandomUuid() => UuidV4().generate();
}
