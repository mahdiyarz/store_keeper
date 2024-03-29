import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_keeper/models/import_models.dart';

import '../helpers/queries/export_queries.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final List<BrandsModel> _brandsList = [];
  final List<IncomingsModel> _incomingList = [];
  final List<CountedIncomingsModel> _countedIncomingsList = [];
  final List<GoodsModel> _goodsList = [];
  final List<CountGoodsModel> _countGoodsList = [];
  final List<PersonsModel> _personsList = [];
  final List<WarehousesModel> _warehousesList = [];
  final List<StockModel> _stocksList = [];
  final List<StockEachWarehouseModel> _stockEachWarehouse = [];
  late String _failureMessage;
  late String _successMessage;

  AppBloc() : super(const AppStateInitial()) {
    on<FetchEvent>(_onFetchEvent);
    on<AddBrand>(_onAddBrand);
    on<EditBrand>(_onEditBrand);
    on<DeleteBrand>(_onDeleteBrand);
    on<AddIncomingList>(_onAddIncomingList);
    on<EditIncomingList>(_onEditIncomingList);
    on<DeleteIncomingList>(_onDeleteIncomingList);
    on<AddCountedIncomings>(_onAddCountedIncomings);
    on<EditCountedIncomings>(_onEditCountedIncomings);
    on<DeleteCountedIncomings>(_onDeleteCountedIncomings);
    on<AddGood>(_onAddGood);
    on<DeleteGood>(_onDeleteGood);
    on<EditGood>(_onEditGood);
    on<AddCountGood>(_onAddCountGood);
    on<AddPerson>(_onAddPerson);
    on<EditPerson>(_onEditPerson);
    on<DeletePerson>(_onDeletePerson);
    on<AddWarehouse>(_onAddWarehouse);
    on<EditWarehouse>(_onEditWarehouse);
  }

  void _onDeleteCountedIncomings(
      DeleteCountedIncomings event, Emitter<AppState> emit) async {
    log('delete counted incoming item');

    final CountedIncomingsModel deletedCountedIncome =
        event.deleteCountedIncomingItem;

    log('step 1');
    log(_stocksList.toString());
    final StockModel deletedStockItem = _stocksList.firstWhere(
        (element) => element.countedIncomingId == deletedCountedIncome.id);

    log('step 2');
    final StockEachWarehouseModel deletedStockEachWarehouseItem =
        _stockEachWarehouse.firstWhere(
            (element) => element.countedIncomingId == deletedCountedIncome.id);

    log('step 3');
    await StockQueries.instance.deleteData(deletedStockItem);
    await StockEachWarehouseQueries.instance
        .deleteData(deletedStockEachWarehouseItem);
    await CountedIncomingsQueries.instance.deleteData(deletedCountedIncome);

    log('step 4');
    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        countedIncomingsList: _countedIncomingsList
          ..remove(deletedCountedIncome),
        stockEachWarehouseList: _stockEachWarehouse
          ..remove(deletedStockEachWarehouseItem),
        stocksList: _stocksList..remove(deletedStockItem),
        goodsList: _goodsList,
        personsList: _personsList,
        warehousesList: _warehousesList,
        countGoodsList: _countGoodsList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onEditCountedIncomings(
      EditCountedIncomings event, Emitter<AppState> emit) async {
    log('edit counted incomings on bloc');

    final CountedIncomingsModel editedCountedIncome =
        event.newCountedIncomingItem;

    final int oldCountedIncomeId = event.oldCountedIncomingId;
    final CountedIncomingsModel deletingOldCountedIncomingItem =
        _countedIncomingsList
            .firstWhere((element) => element.id == oldCountedIncomeId);

    final CountedIncomingsModel finalEditedCountedIncome =
        CountedIncomingsModel(
      id: oldCountedIncomeId,
      incomingsId: editedCountedIncome.incomingsId,
      warehouseId: editedCountedIncome.warehouseId,
      goodId: editedCountedIncome.goodId,
      withoutBox: editedCountedIncome.withoutBox,
      withBoxes: editedCountedIncome.withBoxes,
      price: editedCountedIncome.price,
      totalCounted: editedCountedIncome.totalCounted,
    );

    final StockModel oldStockItem = _stocksList.firstWhere(
        (element) => element.countedIncomingId == oldCountedIncomeId);

    final StockModel finalEditedStock = StockModel(
      id: oldStockItem.id,
      goodId: oldStockItem.goodId,
      totalStock: editedCountedIncome.totalCounted,
      date: oldStockItem.date,
      countedIncomingId: oldStockItem.countedIncomingId,
    );

    final StockEachWarehouseModel oldStockEachWarehouseItem =
        _stockEachWarehouse.firstWhere(
            (element) => element.countedIncomingId == oldCountedIncomeId);

    final StockEachWarehouseModel finalEditedStockEachWarehouse =
        StockEachWarehouseModel(
      id: oldStockEachWarehouseItem.id,
      goodId: oldStockEachWarehouseItem.goodId,
      warehouseId: editedCountedIncome.warehouseId,
      totalStock: editedCountedIncome.totalCounted,
      date: oldStockEachWarehouseItem.date,
      countedIncomingId: oldStockEachWarehouseItem.countedIncomingId,
    );

    if (editedCountedIncome.incomingsId.toString().isNotEmpty &&
        editedCountedIncome.warehouseId.toString().isNotEmpty &&
        editedCountedIncome.goodId.toString().isNotEmpty &&
        editedCountedIncome.withoutBox.toString().isNotEmpty &&
        editedCountedIncome.totalCounted.toString().isNotEmpty) {
      await CountedIncomingsQueries.instance.updateData(
        finalEditedCountedIncome,
      );

      await StockQueries.instance.updateData(
        finalEditedStock,
      );

      await StockEachWarehouseQueries.instance.updateData(
        finalEditedStockEachWarehouse,
      );
    }

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        countedIncomingsList: _countedIncomingsList
          ..remove(deletingOldCountedIncomingItem)
          ..add(finalEditedCountedIncome),
        stockEachWarehouseList: _stockEachWarehouse
          ..remove(oldStockEachWarehouseItem)
          ..add(finalEditedStockEachWarehouse),
        stocksList: _stocksList
          ..remove(oldStockItem)
          ..add(finalEditedStock),
        goodsList: _goodsList,
        personsList: _personsList,
        warehousesList: _warehousesList,
        countGoodsList: _countGoodsList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onAddCountedIncomings(
      AddCountedIncomings event, Emitter<AppState> emit) async {
    log('add counted incomings on bloc');

    final CountedIncomingsModel countedIncomeItem =
        event.addCountedIncomingItem;

    if (countedIncomeItem.incomingsId.toString().isNotEmpty &&
        countedIncomeItem.warehouseId.toString().isNotEmpty &&
        countedIncomeItem.goodId.toString().isNotEmpty &&
        countedIncomeItem.withoutBox.toString().isNotEmpty &&
        countedIncomeItem.totalCounted.toString().isNotEmpty) {
      await CountedIncomingsQueries.instance.insertData(countedIncomeItem);

      final List<CountedIncomingsModel> lastUpdateCountedIncomings =
          await CountedIncomingsQueries.instance.fetchAllData();

      final CountedIncomingsModel recallCountedIncoming =
          lastUpdateCountedIncomings.firstWhere((element) =>
              element.goodId == countedIncomeItem.goodId &&
              element.incomingsId == countedIncomeItem.incomingsId);

      final DateTime date = DateTime.now();

      final StockModel newStockItem = StockModel(
        goodId: recallCountedIncoming.goodId,
        totalStock: recallCountedIncoming.totalCounted,
        date: date,
        countedIncomingId: recallCountedIncoming.id,
      );

      await StockQueries.instance.insertData(
        newStockItem,
      );

      final List<StockModel> lastUpdateStock =
          await StockQueries.instance.fetchAllData();

      final StockEachWarehouseModel newStockEachWarehouseItem =
          StockEachWarehouseModel(
        goodId: recallCountedIncoming.goodId,
        warehouseId: recallCountedIncoming.warehouseId,
        totalStock: recallCountedIncoming.totalCounted,
        date: date,
        countedIncomingId: recallCountedIncoming.id,
      );

      await StockEachWarehouseQueries.instance.insertData(
        newStockEachWarehouseItem,
      );

      final List<StockEachWarehouseModel> lastUpdateStockWarehouse =
          await StockEachWarehouseQueries.instance.fetchAllData();

      emit(
        DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList,
          countedIncomingsList: _countedIncomingsList
            ..clear()
            ..addAll(lastUpdateCountedIncomings),
          stockEachWarehouseList: _stockEachWarehouse
            ..clear()
            ..addAll(lastUpdateStockWarehouse),
          stocksList: _stocksList
            ..clear()
            ..addAll(lastUpdateStock),
          goodsList: _goodsList,
          personsList: _personsList,
          warehousesList: _warehousesList,
          countGoodsList: _countGoodsList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    }
  }

  void _onEditWarehouse(EditWarehouse event, Emitter<AppState> emit) async {
    log('run edit wh');

    final WarehousesModel oldWarehouse = event.oldWarehouse;
    final WarehousesModel editedWarehouse = event.newWarehouse;

    final int oldWarehouseIndex = _warehousesList.indexOf(oldWarehouse);

    if (editedWarehouse.name.isNotEmpty) {
      await WarehouseQueries.instance.updateData(
        WarehousesModel(
          id: oldWarehouse.id,
          name: editedWarehouse.name,
        ),
      );
    }

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        countedIncomingsList: _countedIncomingsList,
        stockEachWarehouseList: _stockEachWarehouse,
        stocksList: _stocksList,
        goodsList: _goodsList,
        personsList: _personsList,
        warehousesList: _warehousesList
          ..remove(oldWarehouse)
          ..insert(oldWarehouseIndex, editedWarehouse),
        countGoodsList: _countGoodsList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onAddWarehouse(AddWarehouse event, Emitter<AppState> emit) async {
    log('run add warehouse');

    final WarehousesModel warehouse = event.warehouse;

    if (warehouse.name.isNotEmpty) {
      await WarehouseQueries.instance.insertData(warehouse);
    }

    final List<WarehousesModel> lastUpdatedWarehouses =
        await WarehouseQueries.instance.fetchAllData();

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        countedIncomingsList: _countedIncomingsList,
        stockEachWarehouseList: _stockEachWarehouse,
        stocksList: _stocksList,
        goodsList: _goodsList,
        personsList: _personsList,
        warehousesList: _warehousesList
          ..clear()
          ..addAll(lastUpdatedWarehouses),
        countGoodsList: _countGoodsList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onDeletePerson(DeletePerson event, Emitter<AppState> emit) async {
    log('run delete person');
  }

  void _onEditPerson(EditPerson event, Emitter<AppState> emit) async {
    log('run edit person');

    final PersonsModel oldPerson = event.oldPerson;
    final PersonsModel editedPerson = event.newPerson;

    final int oldPersonIndex = _personsList.indexOf(oldPerson);

    if (editedPerson.name.isNotEmpty) {
      await PersonsQueries.instance.updateData(
        PersonsModel(
          id: oldPerson.id,
          name: editedPerson.name,
          description: editedPerson.description,
        ),
      );
    }

    emit(
      DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList,
          countedIncomingsList: _countedIncomingsList,
          stockEachWarehouseList: _stockEachWarehouse,
          stocksList: _stocksList,
          goodsList: _goodsList,
          personsList: _personsList
            ..remove(oldPerson)
            ..insert(oldPersonIndex, editedPerson),
          countGoodsList: _countGoodsList,
          warehousesList: _warehousesList,
          failureMessage: _failureMessage,
          successMessage: _successMessage),
    );
  }

  void _onAddPerson(AddPerson event, Emitter<AppState> emit) async {
    log('run ADD Person');
    final PersonsModel person = event.person;

    if (person.name.isNotEmpty) {
      await PersonsQueries.instance.insertData(
        PersonsModel(
          name: person.name,
          description: person.description,
        ),
      );
    }

    final List<PersonsModel> lastUpdatedPersons =
        await PersonsQueries.instance.fetchAllData();

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        countedIncomingsList: _countedIncomingsList,
        stockEachWarehouseList: _stockEachWarehouse,
        stocksList: _stocksList,
        goodsList: _goodsList,
        personsList: _personsList
          ..clear()
          ..addAll(lastUpdatedPersons),
        countGoodsList: _countGoodsList,
        warehousesList: _warehousesList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onFetchEvent(FetchEvent event, Emitter<AppState> emit) async {
    log('start FetchEVENT on bloc');
    _failureMessage = '';
    _successMessage = '';

    _brandsList
      ..clear()
      ..addAll(await BrandsQueries.instance.fetchAllData());
    _incomingList
      ..clear()
      ..addAll(await IncomingsQueries.instance.fetchAllData());
    _goodsList
      ..clear()
      ..addAll(await GoodsQueries.instance.fetchAllData());
    _countGoodsList
      ..clear()
      ..addAll(await CountedGoodsQueries.instance.fetchAllData());
    _personsList
      ..clear()
      ..addAll(await PersonsQueries.instance.fetchAllData());
    _warehousesList
      ..clear()
      ..addAll(await WarehouseQueries.instance.fetchAllData());
    _stockEachWarehouse
      ..clear()
      ..addAll(await StockEachWarehouseQueries.instance.fetchAllData());
    _stocksList
      ..clear()
      ..addAll(await StockQueries.instance.fetchAllData());
    _countedIncomingsList
      ..clear()
      ..addAll(await CountedIncomingsQueries.instance.fetchAllData());

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        countedIncomingsList: _countedIncomingsList,
        stockEachWarehouseList: _stockEachWarehouse,
        stocksList: _stocksList,
        goodsList: _goodsList,
        personsList: _personsList,
        countGoodsList: _countGoodsList,
        warehousesList: _warehousesList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
    log('End FetchEVENT on bloc');
  }

  void _onAddBrand(AddBrand event, Emitter<AppState> emit) async {
    log('run ADD Brand');
    _failureMessage = '';
    _successMessage = '';

    final BrandsModel brand = event.brand;

    if (brand.name.isNotEmpty && brand.latin.isNotEmpty) {
      await BrandsQueries.instance.insertData(
        BrandsModel(
          name: brand.name,
          latin: brand.latin,
        ),
      );
    }

    final List<BrandsModel> lastUpdatedBrands =
        await BrandsQueries.instance.fetchAllData();

    emit(
      DisplayAppState(
        brandsList: _brandsList
          ..clear()
          ..addAll(lastUpdatedBrands),
        incomingList: _incomingList,
        countedIncomingsList: _countedIncomingsList,
        stockEachWarehouseList: _stockEachWarehouse,
        stocksList: _stocksList,
        goodsList: _goodsList,
        personsList: _personsList,
        countGoodsList: _countGoodsList,
        warehousesList: _warehousesList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onEditBrand(EditBrand event, Emitter<AppState> emit) async {
    log('run EDIT Brand');
    _failureMessage = '';
    _successMessage = '';

    final BrandsModel oldBrand = event.oldBrand;
    final BrandsModel editedBrand = event.newBrand;

    final int oldBrandIndex = _brandsList.indexOf(oldBrand);

    if (editedBrand.name.isNotEmpty && editedBrand.latin.isNotEmpty) {
      await BrandsQueries.instance.updateData(BrandsModel(
        id: oldBrand.id,
        name: editedBrand.name,
        latin: editedBrand.latin,
      ));

      emit(
        DisplayAppState(
          brandsList: _brandsList
            ..remove(oldBrand)
            ..insert(oldBrandIndex, editedBrand),
          incomingList: _incomingList,
          countedIncomingsList: _countedIncomingsList,
          stockEachWarehouseList: _stockEachWarehouse,
          stocksList: _stocksList,
          goodsList: _goodsList,
          personsList: _personsList,
          countGoodsList: _countGoodsList,
          warehousesList: _warehousesList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    }
  }

  void _onDeleteBrand(DeleteBrand event, Emitter<AppState> emit) async {
    log('run DELETE Brand');
    _failureMessage = '';
    _successMessage = '';

    final BrandsModel deletedBrand = event.brand;

    // final bool isExistBrandOnIncomingList = _incomingList.isNotEmpty
    //     ? _incomingList
    //         .any((element) => element.id == deletedBrand.id)
    //     : false; //! false means we can delete this brand and it is not exist on incoming list

    final bool isExistBrandOnGoods = _goodsList.isNotEmpty
        ? _goodsList.any((element) => element.brandId == deletedBrand.id)
        : false; //! false means we can delete this brand and it is not exist on goods list

    if (
        // isExistBrandOnIncomingList == false &&
        isExistBrandOnGoods == false) {
      try {
        final response = await BrandsQueries.instance.deleteData(
          BrandsModel(
            id: deletedBrand.id,
            name: deletedBrand.name,
            latin: deletedBrand.latin,
          ),
        );
        if (response == 0) {
          _failureMessage = 'در فرآیند حذف مشکلی پیش آمده است';
          emit(
            DisplayAppState(
              brandsList: _brandsList,
              incomingList: _incomingList,
              countedIncomingsList: _countedIncomingsList,
              stockEachWarehouseList: _stockEachWarehouse,
              stocksList: _stocksList,
              goodsList: _goodsList,
              personsList: _personsList,
              countGoodsList: _countGoodsList,
              warehousesList: _warehousesList,
              failureMessage: _failureMessage,
              successMessage: _successMessage,
            ),
          );
        } else {
          _successMessage = 'با موفقیت حذف شد.';
          emit(
            DisplayAppState(
              brandsList: _brandsList..remove(deletedBrand),
              incomingList: _incomingList,
              countedIncomingsList: _countedIncomingsList,
              stockEachWarehouseList: _stockEachWarehouse,
              stocksList: _stocksList,
              goodsList: _goodsList,
              personsList: _personsList,
              countGoodsList: _countGoodsList,
              warehousesList: _warehousesList,
              failureMessage: _failureMessage,
              successMessage: _successMessage,
            ),
          );
        }
      } catch (e) {
        log(e.toString(), time: DateTime.now());
      }
    } else {
      _failureMessage = 'امکان حذف وجود ندارد.';
      emit(
        DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList,
          countedIncomingsList: _countedIncomingsList,
          stockEachWarehouseList: _stockEachWarehouse,
          stocksList: _stocksList,
          goodsList: _goodsList,
          personsList: _personsList,
          countGoodsList: _countGoodsList,
          warehousesList: _warehousesList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    }
    log('message');
    _failureMessage = '';
    _successMessage = '';
  }

  void _onAddIncomingList(AddIncomingList event, Emitter<AppState> emit) async {
    log('run ADD Incoming List');

    final IncomingsModel incomingListItem = event.addIncomingListItem;

    if (incomingListItem.boxes.toString().isNotEmpty &&
        incomingListItem.personId.toString().isNotEmpty) {
      await IncomingsQueries.instance.insertData(incomingListItem);
    }

    final List<IncomingsModel> lastUpdatedIncomingList =
        await IncomingsQueries.instance.fetchAllData();

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList
          ..clear()
          ..addAll(lastUpdatedIncomingList),
        countedIncomingsList: _countedIncomingsList,
        stockEachWarehouseList: _stockEachWarehouse,
        stocksList: _stocksList,
        goodsList: _goodsList,
        personsList: _personsList,
        countGoodsList: _countGoodsList,
        warehousesList: _warehousesList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onAddGood(AddGood event, Emitter<AppState> emit) async {
    log('run ADD good');

    final GoodsModel good = event.good;

    if (good.name.isNotEmpty &&
        good.latin.isNotEmpty &&
        good.numInBox.toString().isNotEmpty &&
        good.brandId.toString().isNotEmpty) {
      if (good.barcode.toString().isNotEmpty) {
        await GoodsQueries.instance.insertData(
          GoodsModel(
            name: good.name,
            latin: good.latin,
            brandId: good.brandId,
            numInBox: good.numInBox,
            barcode: good.barcode,
          ),
        );
      } else {
        await GoodsQueries.instance.insertData(
          GoodsModel(
            name: good.name,
            latin: good.latin,
            brandId: good.brandId,
            numInBox: good.numInBox,
          ),
        );
      }
    }

    final List<GoodsModel> lastUpdatedGoods =
        await GoodsQueries.instance.fetchAllData();

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        countedIncomingsList: _countedIncomingsList,
        stockEachWarehouseList: _stockEachWarehouse,
        stocksList: _stocksList,
        goodsList: _goodsList
          ..clear()
          ..addAll(lastUpdatedGoods),
        personsList: _personsList,
        countGoodsList: _countGoodsList,
        warehousesList: _warehousesList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onDeleteGood(DeleteGood event, Emitter<AppState> emit) async {
    log('run DELETE Good');

    final GoodsModel deletedGood = event.deletedGood;

    final bool isExistGoodOnCountGoods = _countGoodsList.isNotEmpty
        ? _countGoodsList.any((element) => element.goodsId == deletedGood.id)
        : false; //! false means we can delete this brand and it is not exist on count goods list
    if (isExistGoodOnCountGoods == false) {
      await GoodsQueries.instance.deleteData(deletedGood);
      emit(
        DisplayAppState(
            brandsList: _brandsList,
            incomingList: _incomingList,
            countedIncomingsList: _countedIncomingsList,
            stockEachWarehouseList: _stockEachWarehouse,
            stocksList: _stocksList,
            goodsList: _goodsList..remove(deletedGood),
            personsList: _personsList,
            countGoodsList: _countGoodsList,
            warehousesList: _warehousesList,
            failureMessage: _failureMessage,
            successMessage: _successMessage),
      );
    }
  }

  void _onEditGood(EditGood event, Emitter<AppState> emit) async {
    log('run Edit good');

    final int goodId = event.oldGoodId;
    final GoodsModel oldGood =
        _goodsList.firstWhere((element) => element.id == goodId);

    final GoodsModel editedGood = event.editedGood;

    final int oldGoodIndex = _goodsList.indexOf(oldGood);

    if (editedGood.name.isNotEmpty &&
        editedGood.latin.isNotEmpty &&
        editedGood.brandId.toString().isNotEmpty &&
        editedGood.numInBox.toString().isNotEmpty) {
      await GoodsQueries.instance.updateData(
        GoodsModel(
          id: goodId,
          name: editedGood.name,
          latin: editedGood.latin,
          brandId: editedGood.brandId,
          numInBox: editedGood.numInBox,
          barcode: editedGood.barcode,
          accountingCode: editedGood.accountingCode,
        ),
      );

      emit(
        DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList,
          countedIncomingsList: _countedIncomingsList,
          stockEachWarehouseList: _stockEachWarehouse,
          stocksList: _stocksList,
          goodsList: _goodsList
            ..remove(oldGood)
            ..insert(
              oldGoodIndex,
              GoodsModel(
                id: goodId,
                name: editedGood.name,
                latin: editedGood.latin,
                brandId: editedGood.brandId,
                numInBox: editedGood.numInBox,
                accountingCode: editedGood.accountingCode,
                barcode: editedGood.barcode,
              ),
            ),
          personsList: _personsList,
          countGoodsList: _countGoodsList,
          warehousesList: _warehousesList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    }
  }

  void _onEditIncomingList(
      EditIncomingList event, Emitter<AppState> emit) async {
    final int incomeId = event.oldIncomingListId;
    final IncomingsModel oldIncomingList =
        _incomingList.firstWhere((element) => element.incomingId == incomeId);

    final IncomingsModel editedIncomingList = event.newIncomingListItem;

    final int oldIncomeIndex = _incomingList.indexOf(oldIncomingList);

    if (editedIncomingList.boxes.toString().isNotEmpty &&
        editedIncomingList.personId.toString().isNotEmpty &&
        editedIncomingList.incomingDate.toString().isNotEmpty) {
      await IncomingsQueries.instance.updateData(
        IncomingsModel(
          incomingId: incomeId,
          personId: editedIncomingList.personId,
          boxes: editedIncomingList.boxes,
          incomingDate: editedIncomingList.incomingDate,
        ),
      );

      emit(
        DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList
            ..remove(oldIncomingList)
            ..insert(
              oldIncomeIndex,
              IncomingsModel(
                incomingId: incomeId,
                personId: editedIncomingList.personId,
                boxes: editedIncomingList.boxes,
                incomingDate: editedIncomingList.incomingDate,
              ),
            ),
          countedIncomingsList: _countedIncomingsList,
          stockEachWarehouseList: _stockEachWarehouse,
          stocksList: _stocksList,
          goodsList: _goodsList,
          personsList: _personsList,
          countGoodsList: _countGoodsList,
          warehousesList: _warehousesList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    }
  }

  void _onDeleteIncomingList(
      DeleteIncomingList event, Emitter<AppState> emit) async {
    final IncomingsModel deletedIncomeItem = event.deleteIncomingListItem;

    final bool isExistIncomingListOnCountGoods = _countGoodsList.isNotEmpty
        ? _countGoodsList.any(
            (element) => element.incomingListId == deletedIncomeItem.incomingId)
        : false; //! false means it is not exist on count goods list

    if (isExistIncomingListOnCountGoods == true) {
      await CountedGoodsQueries.instance
          .deleteDataByIncomingList(deletedIncomeItem);
      await IncomingsQueries.instance.deleteData(deletedIncomeItem);
      emit(
        DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList..remove(deletedIncomeItem),
          countedIncomingsList: _countedIncomingsList,
          stockEachWarehouseList: _stockEachWarehouse,
          stocksList: _stocksList,
          goodsList: _goodsList,
          personsList: _personsList,
          countGoodsList: _countGoodsList
            ..removeWhere((element) =>
                element.incomingListId == deletedIncomeItem.incomingId),
          warehousesList: _warehousesList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    } else {
      await IncomingsQueries.instance.deleteData(deletedIncomeItem);
      emit(
        DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList..remove(deletedIncomeItem),
          countedIncomingsList: _countedIncomingsList,
          stockEachWarehouseList: _stockEachWarehouse,
          stocksList: _stocksList,
          goodsList: _goodsList,
          personsList: _personsList,
          countGoodsList: _countGoodsList,
          warehousesList: _warehousesList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    }
  }

  void _onAddCountGood(AddCountGood event, Emitter<AppState> emit) async {
    log('run add count');
    final CountGoodsModel countedGood = event.countedGood;

    if (countedGood.goodsId.toString().isNotEmpty) {
      await CountedGoodsQueries.instance.insertData(
        CountGoodsModel(
          numOfBox: countedGood.numOfBox,
          numOfSeed: countedGood.numOfSeed,
          price: countedGood.price,
          goodsId: countedGood.goodsId,
          incomingListId: countedGood.incomingListId,
          lakingId: countedGood.lakingId,
        ),
      );
    }

    final List<CountGoodsModel> lastUpdatedCountGoods =
        await CountedGoodsQueries.instance.fetchAllData();

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        countedIncomingsList: _countedIncomingsList,
        stockEachWarehouseList: _stockEachWarehouse,
        stocksList: _stocksList,
        goodsList: _goodsList,
        personsList: _personsList,
        countGoodsList: _countGoodsList
          ..clear()
          ..addAll(lastUpdatedCountGoods),
        warehousesList: _warehousesList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }
}
