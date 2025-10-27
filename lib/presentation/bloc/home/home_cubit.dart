import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/util/extensions.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(IdleState());

  void refreshAudioRecordings() {
    safeEmit(RefreshAudioRecordings());

    // Reset the state.
    safeEmit(IdleState());
  }
}
