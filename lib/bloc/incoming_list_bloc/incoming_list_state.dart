part of 'incoming_list_bloc.dart';

abstract class IncomingListState extends Equatable {
  const IncomingListState();
  
  @override
  List<Object> get props => [];
}

class IncomingListInitial extends IncomingListState {}
