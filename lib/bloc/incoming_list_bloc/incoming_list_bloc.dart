import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'incoming_list_event.dart';
part 'incoming_list_state.dart';

class IncomingListBloc extends Bloc<IncomingListEvent, IncomingListState> {
  IncomingListBloc() : super(IncomingListInitial()) {
    on<IncomingListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
