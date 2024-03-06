import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveInitial()) {
    on<LeaveEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
