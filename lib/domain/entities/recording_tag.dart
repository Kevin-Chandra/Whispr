import 'package:equatable/equatable.dart';
import 'package:whispr/util/uuid_util.dart';

class RecordingTag extends Equatable {
  final String id;
  final String label;

  const RecordingTag({
    required this.id,
    required this.label,
  });

  factory RecordingTag.mock1() =>
      RecordingTag(id: UuidUtil.getRandomUuid(), label: 'Mock 1');

  factory RecordingTag.mock2() =>
      RecordingTag(id: UuidUtil.getRandomUuid(), label: 'Mock 2');

  factory RecordingTag.mock3() =>
      RecordingTag(id: UuidUtil.getRandomUuid(), label: 'Mock 3');

  factory RecordingTag.placeholder() => RecordingTag(id: '', label: '');

  @override
  List<Object?> get props => [id, label];
}
