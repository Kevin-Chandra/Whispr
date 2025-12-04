import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/settings/clear_all_data_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'clear_all_data_state.dart';

class ClearAllDataCubit extends Cubit<ClearAllDataState> {
  ClearAllDataCubit() : super(IdleState());

  void deleteAllData() async {
    safeEmit(ClearAllDataLoadingState());

    final response = await di.get<ClearAllDataUseCase>().call();
    response.fold(
      (success) => safeEmit(ClearAllDataSuccessState()),
      (error) => safeEmit(ClearAllDataErrorState(error: error)),
    );
  }

  void resetState() {
    safeEmit(IdleState());
  }
}
