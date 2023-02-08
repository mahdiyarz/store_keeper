// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final List<BrandsModel> brandsList;
  final List<IncomingListModel> allIncomingLists;

  const DisplayAllIncomingList({
    required this.brandsList,
    required this.allIncomingLists,
  });

  @override
  List<Object> get props => [
        allIncomingLists,
        brandsList,
      ];
}

@immutable
class DisplaySpecificIncomingList extends IncomingListState {
  final IncomingListModel specificIncomingList;

  const DisplaySpecificIncomingList({required this.specificIncomingList});

  @override
  List<Object> get props => [specificIncomingList];
}
