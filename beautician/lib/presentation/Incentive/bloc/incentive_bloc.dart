import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'incentive_event.dart';
part 'incentive_state.dart';

class IncentiveBloc extends Bloc<IncentiveEvent, IncentiveState> {
  IncentiveBloc() : super(IncentiveInitial()) {
    on<IncentiveEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
