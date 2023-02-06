part of 'incoming_list_bloc.dart';

@immutable
abstract class IncomingListEvent extends Equatable {
  const IncomingListEvent();

  @override
  List<Object> get props => [];
}

@immutable
class FetchAllIncomingLists extends IncomingListEvent {
  const FetchAllIncomingLists();

  @override
  List<Object> get props => [];
}

@immutable
class FetchSpecificIncomingLists extends IncomingListEvent {
  final IncomingListModel fetchSpecificIncomingList;
  const FetchSpecificIncomingLists({required this.fetchSpecificIncomingList});

  @override
  List<Object> get props => [fetchSpecificIncomingList];
}
