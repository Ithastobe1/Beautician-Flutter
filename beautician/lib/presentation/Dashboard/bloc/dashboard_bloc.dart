import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitialState()) {
    on<DashboardInitialEvent>(dashboardInitialEvent);
    on<DashboardOpenServicePageEvent>(dashboardOpenServicePageEvent);
    on<DashboardOpenDirectionPageEvent>(dashboardOpenDirectionPageEvent);
    on<DashboardOpenChatPageEvent>(dashboardOpenChatPageEvent);
    on<DashboardOpenCallCustomerEvent>(dashboardOpenCallCustomerEvent);
    on<DashboardOpenLeavePageEvent>(dashboardOpenLeavePageEvent);
    on<DashboardOpenTrainingPageEvent>(dashboardOpenTrainingPageEvent);
    on<DashboardOpenDashboardPageEvent>(dashboardOpenDashboardPageEvent);
  }

  FutureOr<void> dashboardInitialEvent(
      DashboardInitialEvent event, Emitter<DashboardState> emit) {
    emit(DashboardInitialState());
  }

  FutureOr<void> dashboardOpenServicePageEvent(
      DashboardOpenServicePageEvent event, Emitter<DashboardState> emit) {
    emit(DashboardOpenServicePageState());
  }

  FutureOr<void> dashboardOpenDirectionPageEvent(
      DashboardOpenDirectionPageEvent event, Emitter<DashboardState> emit) {
    emit(DashboardOpenDirectionPageState());
  }

  FutureOr<void> dashboardOpenChatPageEvent(
      DashboardOpenChatPageEvent event, Emitter<DashboardState> emit) {
    emit(DashboardOpenChatPageState());
  }

  FutureOr<void> dashboardOpenCallCustomerEvent(
      DashboardOpenCallCustomerEvent event, Emitter<DashboardState> emit) {
    emit(DashboardOpenCallCustomerState());
  }

  FutureOr<void> dashboardOpenTrainingPageEvent(
      DashboardOpenTrainingPageEvent event, Emitter<DashboardState> emit) {
    emit(DashboardOpenTrainingPageState());
  }

  FutureOr<void> dashboardOpenDashboardPageEvent(
      DashboardOpenDashboardPageEvent event, Emitter<DashboardState> emit) {
    emit(DashboardOpenDashboardPageState());
  }

  FutureOr<void> dashboardOpenLeavePageEvent(
      DashboardOpenLeavePageEvent event, Emitter<DashboardState> emit) {
    emit(DashboardOpenLeavePageState());
  }
}
