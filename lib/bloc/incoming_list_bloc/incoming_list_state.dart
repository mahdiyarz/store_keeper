part of 'incoming_list_bloc.dart';

@immutable
abstract class IncomingListState extends Equatable {
  const IncomingListState();

  @override
  List<Object> get props => [];
}

@immutable
class IncomingListInitial extends IncomingListState {
  const IncomingListInitial();

  @override
  List<Object> get props => [];
}

@immutable
class DisplayAllIncomingList extends IncomingListState {
  final List<IncomingListModel> allIncomingLists;

  const DisplayAllIncomingList({required this.allIncomingLists});

  @override
  List<Object> get props => [allIncomingLists];
}

@immutable
class DisplaySpecificIncomingList extends IncomingListState {
  final IncomingListModel specificIncomingList;

  const DisplaySpecificIncomingList({required this.specificIncomingList});

  @override
  List<Object> get props => [specificIncomingList];
}
