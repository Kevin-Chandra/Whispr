import 'dart:io';

import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/archive/backup_recordings_use_case.dart';
import 'package:whispr/domain/use_case/archive/get_recent_backup_use_case.dart';
import 'package:whispr/domain/use_case/archive/save_file_to_directory_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/get_recording_first_and_last_date_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'backup_state.dart';

class BackupCubit extends Cubit<BackupState> {
  BackupCubit() : super(InitialLoadingState()) {
    _initialise();
  }

  CancelableOperation<Either<File, FailureEntity>>? _backupOperation;
  DateTime _recordingFirstDate = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  File? _recentBackup;

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
      response.fold(
        (file) {
          _recentBackup = file;
          safeEmit(BackupSuccessState(file: file));
          _emitIdleState();
        },
        (error) => safeEmit(BackupErrorState(error: error)),
      );
    }, onCancel: () {
      safeEmit(
          BackupErrorState(error: FailureEntity(error: "Operation cancelled")));
    });

    _backupOperation = null;
  }

  void downloadToCustomDirectory() async {
    if (_recentBackup == null) {
      return;
    }

    final response =
        await di.get<SaveFileToDirectoryUseCase>().call(file: _recentBackup!);
    response.fold((success) {
      safeEmit(SaveFileSuccessState());
    }, (error) {
      safeEmit(BackupErrorState(error: error));
    });
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
      recentBackup: _recentBackup,
    ));
  }

  void _initialise() async {
    await Future.wait([
      _getRecentBackup(),
      _getFirstAndLastDate(),
    ]);

    _emitIdleState();
  }

  Future<void> _getRecentBackup() async {
    final file = await di.get<GetRecentBackupUseCase>().call();

    if (file != null) {
      _recentBackup = file;
    }
  }

  Future<void> _getFirstAndLastDate() async {
    final response = await di.get<GetRecordingFirstAndLastDateUseCase>().call();

    if (response != null) {
      _recordingFirstDate = response.$1;
      _startDate = response.$1;
      _endDate = response.$2;
    }
  }

  void resetState() {
    _emitIdleState();
  }
}
