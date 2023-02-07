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

@immutable
class AddIncomingLists extends IncomingListEvent {
  final IncomingListModel addIncomingList;
  const AddIncomingLists({required this.addIncomingList});

  @override
  List<Object> get props => [addIncomingList];
}

@immutable
class DeleteIncomingLists extends IncomingListEvent {
  final IncomingListModel deleteIncomingList;
  const DeleteIncomingLists({required this.deleteIncomingList});

  @override
  List<Object> get props => [deleteIncomingList];
}

@immutable
class EditIncomingLists extends IncomingListEvent {
  final IncomingListModel oldIncomingList;
  final IncomingListModel newIncomingList;
  const EditIncomingLists({
    required this.oldIncomingList,
    required this.newIncomingList,
  });

  @override
  List<Object> get props => [
        oldIncomingList,
        newIncomingList,
      ];
}
