import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/archive/restore_recordings_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'restore_state.dart';

class RestoreCubit extends Cubit<RestoreState> {
  RestoreCubit() : super(IdleState());

  File? selectedFile;

  void setFile(File file) {
    selectedFile = file;
    safeEmit(IdleState(file: selectedFile));
  }

  void removeFile() {
    selectedFile = null;
    safeEmit(IdleState());
  }

  void restore() async {
    safeEmit(RestoreLoadingState());

    if (selectedFile == null) {
      safeEmit(
          RestoreErrorState(error: FailureEntity(error: 'No file selected')));
      return;
    }

    final restoreResponse =
        await di.get<RestoreRecordingsUseCase>().call(selectedFile!.path);
    restoreResponse.fold(
      (success) => safeEmit(RestoreSuccessState()),
      (error) => safeEmit(RestoreErrorState(error: error)),
    );
  }
}
