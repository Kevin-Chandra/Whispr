import 'dart:io';

import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/archive/backup_recordings_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/get_recording_first_and_last_date_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'backup_state.dart';

class BackupCubit extends Cubit<BackupState> {
  BackupCubit() : super(InitialLoadingState()) {
    _getFirstAndLastDate();
  }

  CancelableOperation<Either<File, FailureEntity>>? _backupOperation;
  DateTime _recordingFirstDate = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  void startBackup({required String fileName}) {
    safeEmit(BackupLoadingState());

    final backup = di.get<BackupRecordingsUseCase>().call(
          fileName: fileName,
          startDate: _startDate,
          endDate: _endDate,
        );

    _backupOperation =
        CancelableOperation<Either<File, FailureEntity>>.fromFuture(backup);

    _backupOperation!.then((response) {
      safeEmit(response.fold(
        (file) => BackupSuccessState(file: file),
        (error) => BackupErrorState(error: error),
      ));
    }, onCancel: () {
      safeEmit(
          BackupErrorState(error: FailureEntity(error: "Operation cancelled")));
    });

    _backupOperation = null;
  }

  void setStartDate(DateTime date) async {
    _startDate = date;
    _emitIdleState();
  }

  void setEndDate(DateTime date) async {
    _endDate = date;
    _emitIdleState();
  }

  @override
  Future<void> close() {
    _backupOperation?.cancel();
    return super.close();
  }

  void _emitIdleState() {
    safeEmit(IdleState(
      recordingFirstDate: _recordingFirstDate,
      startDate: _startDate,
      endDate: _endDate,
    ));
  }

  void _getFirstAndLastDate() async {
    final response = await di.get<GetRecordingFirstAndLastDateUseCase>().call();

    if (response != null) {
      _recordingFirstDate = response.$1;
      _startDate = response.$1;
      _endDate = response.$2;
    }

    _emitIdleState();
  }

  void resetState() {
    _emitIdleState();
  }
}
