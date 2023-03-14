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

//* Stock CRUD

@immutable
class AddStock extends AppEvent {
  final StockModel stock;
  const AddStock({
    required this.stock,
  });

  @override
  List<Object> get props => [
        stock,
      ];
}

@immutable
class DeleteStock extends AppEvent {
  final StockModel stock;
  const DeleteStock({
    required this.stock,
  });

  @override
  List<Object> get props => [
        stock,
      ];
}

@immutable
class EditStock extends AppEvent {
  final StockModel oldStock;
  final StockModel newStock;
  const EditStock({
    required this.oldStock,
    required this.newStock,
  });

  @override
  List<Object> get props => [
        oldStock,
        newStock,
      ];
}

//* Stock CRUD

@immutable
class AddStockEachWarehouse extends AppEvent {
  final StockEachWarehouseModel stock;
  const AddStockEachWarehouse({
    required this.stock,
  });

  @override
  List<Object> get props => [
        stock,
      ];
}

@immutable
class DeleteStockEachWarehouse extends AppEvent {
  final StockEachWarehouseModel stock;
  const DeleteStockEachWarehouse({
    required this.stock,
  });

  @override
  List<Object> get props => [
        stock,
      ];
}

@immutable
class EditStockEachWarehouse extends AppEvent {
  final StockEachWarehouseModel oldStock;
  final StockEachWarehouseModel newStock;
  const EditStockEachWarehouse({
    required this.oldStock,
    required this.newStock,
  });

  @override
  List<Object> get props => [
        oldStock,
        newStock,
      ];
}

//* Persons CRUD

@immutable
class AddPerson extends AppEvent {
  final PersonsModel person;
  const AddPerson({
    required this.person,
  });

  @override
  List<Object> get props => [
        person,
      ];
}

@immutable
class DeletePerson extends AppEvent {
  final PersonsModel person;
  const DeletePerson({
    required this.person,
  });

  @override
  List<Object> get props => [
        person,
      ];
}

@immutable
class EditPerson extends AppEvent {
  final PersonsModel oldPerson;
  final PersonsModel newPerson;
  const EditPerson({
    required this.oldPerson,
    required this.newPerson,
  });

  @override
  List<Object> get props => [
        oldPerson,
        newPerson,
      ];
}

//* Warehouse CRUD

@immutable
class AddWarehouse extends AppEvent {
  final WarehousesModel warehouse;
  const AddWarehouse({
    required this.warehouse,
  });

  @override
  List<Object> get props => [
        warehouse,
      ];
}

@immutable
class DeleteWarehouse extends AppEvent {
  final WarehousesModel warehouse;
  const DeleteWarehouse({
    required this.warehouse,
  });

  @override
  List<Object> get props => [
        warehouse,
      ];
}

@immutable
class EditWarehouse extends AppEvent {
  final WarehousesModel oldWarehouse;
  final WarehousesModel newWarehouse;
  const EditWarehouse({
    required this.oldWarehouse,
    required this.newWarehouse,
  });

  @override
  List<Object> get props => [
        oldWarehouse,
        newWarehouse,
      ];
}

//* Incoming List CRUD

@immutable
class AddIncomingList extends AppEvent {
  final IncomingsModel addIncomingListItem;
  const AddIncomingList({required this.addIncomingListItem});

  @override
  List<Object> get props => [addIncomingListItem];
}

@immutable
class DeleteIncomingList extends AppEvent {
  final IncomingsModel deleteIncomingListItem;
  const DeleteIncomingList({required this.deleteIncomingListItem});

  @override
  List<Object> get props => [deleteIncomingListItem];
}

@immutable
class EditIncomingList extends AppEvent {
  final int oldIncomingListId;
  final IncomingsModel newIncomingListItem;
  const EditIncomingList({
    required this.oldIncomingListId,
    required this.newIncomingListItem,
  });

  @override
  List<Object> get props => [
        oldIncomingListId,
        newIncomingListItem,
      ];
}

//* Counted Incomings CRUD

@immutable
class AddCountedIncomings extends AppEvent {
  final CountedIncomingsModel addCountedIncomingItem;
  const AddCountedIncomings({required this.addCountedIncomingItem});

  @override
  List<Object> get props => [addCountedIncomingItem];
}

@immutable
class DeleteCountedIncomings extends AppEvent {
  final CountedIncomingsModel deleteCountedIncomingItem;
  const DeleteCountedIncomings({required this.deleteCountedIncomingItem});

  @override
  List<Object> get props => [deleteCountedIncomingItem];
}

@immutable
class EditCountedIncomings extends AppEvent {
  final int oldCountedIncomingId;
  final CountedIncomingsModel newCountedIncomingItem;
  const EditCountedIncomings({
    required this.oldCountedIncomingId,
    required this.newCountedIncomingItem,
  });

  @override
  List<Object> get props => [
        oldCountedIncomingId,
        newCountedIncomingItem,
      ];
}

//* Goods CRUD

@immutable
class AddGood extends AppEvent {
  final GoodsModel good;
  const AddGood({
    required this.good,
  });

  @override
  List<Object> get props => [
        good,
      ];
}

class DeleteGood extends AppEvent {
  final GoodsModel deletedGood;
  const DeleteGood({
    required this.deletedGood,
  });

  @override
  List<Object> get props => [
        deletedGood,
      ];
}

class EditGood extends AppEvent {
  final int oldGoodId;
  final GoodsModel editedGood;
  const EditGood({
    required this.oldGoodId,
    required this.editedGood,
  });

  @override
  List<Object> get props => [
        oldGoodId,
        editedGood,
      ];
}

//* Count Goods CRUD

@immutable
class AddCountGood extends AppEvent {
  final CountGoodsModel countedGood;
  const AddCountGood({
    required this.countedGood,
  });

  @override
  List<Object> get props => [
        countedGood,
      ];
}
