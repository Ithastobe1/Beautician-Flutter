import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'inventary_event.dart';
part 'inventary_state.dart';

class InventaryBloc extends Bloc<InventaryEvent, InventaryState> {
  InventaryBloc() : super(InventaryInitial()) {
    on<InventaryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
