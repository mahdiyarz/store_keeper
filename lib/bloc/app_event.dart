part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

@immutable
class FetchEvent extends AppEvent {
  const FetchEvent();

  @override
  List<Object> get props => [];
}

//* Brands CRUD

@immutable
class AddBrand extends AppEvent {
  final BrandsModel brand;
  const AddBrand({
    required this.brand,
  });

  @override
  List<Object> get props => [
        brand,
      ];
}

@immutable
class DeleteBrand extends AppEvent {
  final BrandsModel brand;
  const DeleteBrand({
    required this.brand,
  });

  @override
  List<Object> get props => [
        brand,
      ];
}

@immutable
class EditBrand extends AppEvent {
  final BrandsModel oldBrand;
  final BrandsModel newBrand;
  const EditBrand({
    required this.oldBrand,
    required this.newBrand,
  });

  @override
  List<Object> get props => [
        oldBrand,
        newBrand,
      ];
}

//* Incoming List CRUD

@immutable
class AddIncomingList extends AppEvent {
  final IncomingListModel addIncomingListItem;
  const AddIncomingList({required this.addIncomingListItem});

  @override
  List<Object> get props => [addIncomingListItem];
}

@immutable
class DeleteIncomingList extends AppEvent {
  final IncomingListModel deleteIncomingListItem;
  const DeleteIncomingList({required this.deleteIncomingListItem});

  @override
  List<Object> get props => [deleteIncomingListItem];
}

@immutable
class EditIncomingList extends AppEvent {
  final IncomingListModel oldIncomingListItem;
  final IncomingListModel newIncomingListItem;
  const EditIncomingList({
    required this.oldIncomingListItem,
    required this.newIncomingListItem,
  });

  @override
  List<Object> get props => [
        oldIncomingListItem,
        newIncomingListItem,
      ];
}
