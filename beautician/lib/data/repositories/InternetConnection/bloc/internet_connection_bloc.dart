import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'internet_connection_event.dart';
part 'internet_connection_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  InternetConnectionBloc() : super(InternetConnectionInitialState()) {
    on<InternetConnectionInitialEvent>(internetConnectionInitialEvent);
    on<InternetConnectionGainedEvent>(internetConnectionGainedEvent);
    on<InternetConnectionLossEvent>(internetConnectionLossEvent);
  }

  FutureOr<void> internetConnectionInitialEvent(
      InternetConnectionInitialEvent event,
      Emitter<InternetConnectionState> emit) {
    emit(InternetConnectionInitialState());
  }

  FutureOr<void> internetConnectionGainedEvent(
      InternetConnectionGainedEvent event,
      Emitter<InternetConnectionState> emit) {
    emit(InternetConnectionGainedState());
  }

  FutureOr<void> internetConnectionLossEvent(InternetConnectionLossEvent event,
      Emitter<InternetConnectionState> emit) {
    emit(InternetConnectionLossState());
  }
}
