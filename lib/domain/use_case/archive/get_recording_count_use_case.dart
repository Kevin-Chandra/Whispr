import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/archive_repository.dart';

@injectable
class GetRecordingCountUseCase {
  ///
  /// A use case to calculate recording count, given a date range.
  ///
  const GetRecordingCountUseCase(this._archiveRepository);

  final ArchiveRepository _archiveRepository;

  Future<int> call({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _archiveRepository.getRecordCountByDateRange(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
