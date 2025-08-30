import 'package:whispr/util/uuid_util.dart';

class RecordingTag {
  final String id;
  final String label;

  RecordingTag({
    required this.id,
    required this.label,
  });

  factory RecordingTag.mock1() =>
      RecordingTag(id: UuidUtil.getRandomUuid(), label: 'Mock 1');

  factory RecordingTag.mock2() =>
      RecordingTag(id: UuidUtil.getRandomUuid(), label: 'Mock 2');

  factory RecordingTag.mock3() =>
      RecordingTag(id: UuidUtil.getRandomUuid(), label: 'Mock 3');
}
