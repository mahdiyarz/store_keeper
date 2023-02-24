import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:store_keeper/helpers/db_helper.dart';
import 'package:store_keeper/models/import_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final List<BrandsModel> _brandsList = [];
  final List<IncomingListModel> _incomingList = [];
  final List<GoodsModel> _goodsList = [];
  final List<CountGoodsModel> _countGoodsList = [];
  final List<LakingModel> _lakingList = [];
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
    on<AddGood>(_onAddGood);
    on<DeleteGood>(_onDeleteGood);
    on<EditGood>(_onEditGood);
  }

  void _onFetchEvent(FetchEvent event, Emitter<AppState> emit) async {
    log('start FetchEVENT on bloc');
    _failureMessage = '';
    _successMessage = '';

    _brandsList
      ..clear()
      ..addAll(await DBHelper.instance.fetchBrandsData());
    _incomingList
      ..clear()
      ..addAll(await DBHelper.instance.fetchIncomingListData());
    _goodsList
      ..clear()
      ..addAll(await DBHelper.instance.fetchGoodsData());
    _countGoodsList
      ..clear()
      ..addAll(await DBHelper.instance.fetchCountGoodsData());
    _lakingList
      ..clear()
      ..addAll(await DBHelper.instance.fetchLakingData());

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        goodsList: _goodsList,
        countGoodsList: _countGoodsList,
        lakingList: _lakingList,
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

    if (brand.brandName.isNotEmpty && brand.brandLatinName.isNotEmpty) {
      await DBHelper.instance.insertBrands(
        BrandsModel(
          brandName: brand.brandName,
          brandLatinName: brand.brandLatinName,
        ),
      );
    }

    final List<BrandsModel> lastUpdatedBrands =
        await DBHelper.instance.fetchBrandsData();

    emit(
      DisplayAppState(
        brandsList: _brandsList
          ..clear()
          ..addAll(lastUpdatedBrands),
        incomingList: _incomingList,
        goodsList: _goodsList,
        countGoodsList: _countGoodsList,
        lakingList: _lakingList,
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

    if (editedBrand.brandName.isNotEmpty &&
        editedBrand.brandLatinName.isNotEmpty) {
      await DBHelper.instance.updateBrands(BrandsModel(
        brandId: oldBrand.brandId,
        brandName: editedBrand.brandName,
        brandLatinName: editedBrand.brandLatinName,
      ));

      emit(
        DisplayAppState(
          brandsList: _brandsList
            ..remove(oldBrand)
            ..insert(oldBrandIndex, editedBrand),
          incomingList: _incomingList,
          goodsList: _goodsList,
          countGoodsList: _countGoodsList,
          lakingList: _lakingList,
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

    final bool isExistBrandOnIncomingList = _incomingList.isNotEmpty
        ? _incomingList
            .any((element) => element.brandId == deletedBrand.brandId)
        : false; //! false means we can delete this brand and it is not exist on incoming list

    final bool isExistBrandOnGoods = _goodsList.isNotEmpty
        ? _goodsList.any((element) => element.brandId == deletedBrand.brandId)
        : false; //! false means we can delete this brand and it is not exist on goods list

    if (isExistBrandOnIncomingList == false && isExistBrandOnGoods == false) {
      try {
        final response = await DBHelper.instance.deleteBrands(
          BrandsModel(
            brandId: deletedBrand.brandId,
            brandName: deletedBrand.brandName,
            brandLatinName: deletedBrand.brandLatinName,
          ),
        );
        if (response == 0) {
          _failureMessage = 'در فرآیند حذف مشکلی پیش آمده است';
          emit(
            DisplayAppState(
              brandsList: _brandsList,
              incomingList: _incomingList,
              goodsList: _goodsList,
              countGoodsList: _countGoodsList,
              lakingList: _lakingList,
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
              goodsList: _goodsList,
              countGoodsList: _countGoodsList,
              lakingList: _lakingList,
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
          goodsList: _goodsList,
          countGoodsList: _countGoodsList,
          lakingList: _lakingList,
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

    final IncomingListModel incomingListItem = event.addIncomingListItem;

    if (incomingListItem.numOfBoxes.toString().isNotEmpty &&
        incomingListItem.brandId.toString().isNotEmpty) {
      await DBHelper.instance.insertIncomingList(incomingListItem);
    }

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList..insert(0, incomingListItem),
        goodsList: _goodsList,
        countGoodsList: _countGoodsList,
        lakingList: _lakingList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onAddGood(AddGood event, Emitter<AppState> emit) async {
    log('run ADD good');

    final GoodsModel good = event.good;

    if (good.goodName.isNotEmpty &&
        good.goodLatinName.isNotEmpty &&
        good.numInBox.toString().isNotEmpty &&
        good.brandId.toString().isNotEmpty) {
      if (good.barcode.toString().isNotEmpty) {
        await DBHelper.instance.insertGoods(
          GoodsModel(
            goodName: good.goodName,
            goodLatinName: good.goodLatinName,
            brandId: good.brandId,
            numInBox: good.numInBox,
            barcode: good.barcode,
          ),
        );
      } else {
        await DBHelper.instance.insertGoods(
          GoodsModel(
            goodName: good.goodName,
            goodLatinName: good.goodLatinName,
            brandId: good.brandId,
            numInBox: good.numInBox,
          ),
        );
      }
    }

    final List<GoodsModel> lastUpdatedGoods =
        await DBHelper.instance.fetchGoodsData();

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        goodsList: _goodsList
          ..clear()
          ..addAll(lastUpdatedGoods),
        countGoodsList: _countGoodsList,
        lakingList: _lakingList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }

  void _onDeleteGood(DeleteGood event, Emitter<AppState> emit) async {
    log('run DELETE Good');

    final GoodsModel deletedGood = event.deletedGood;

    final bool isExistGoodOnCountGoods = _countGoodsList.isNotEmpty
        ? _countGoodsList
            .any((element) => element.goodsId == deletedGood.goodId)
        : false; //! false means we can delete this brand and it is not exist on count goods list
    if (isExistGoodOnCountGoods == false) {
      await DBHelper.instance.deleteGoods(deletedGood);
      emit(
        DisplayAppState(
            brandsList: _brandsList,
            incomingList: _incomingList,
            goodsList: _goodsList..remove(deletedGood),
            countGoodsList: _countGoodsList,
            lakingList: _lakingList,
            failureMessage: _failureMessage,
            successMessage: _successMessage),
      );
    }
  }

  void _onEditGood(EditGood event, Emitter<AppState> emit) async {
    log('run Edit good');

    final int goodId = event.oldGoodId;
    final GoodsModel oldGood =
        _goodsList.firstWhere((element) => element.goodId == goodId);

    final GoodsModel editedGood = event.editedGood;

    final int oldGoodIndex = _goodsList.indexOf(oldGood);

    if (editedGood.goodName.isNotEmpty &&
        editedGood.goodLatinName.isNotEmpty &&
        editedGood.brandId.toString().isNotEmpty &&
        editedGood.numInBox.toString().isNotEmpty) {
      await DBHelper.instance.updateGoods(
        GoodsModel(
          goodId: goodId,
          goodName: editedGood.goodName,
          goodLatinName: editedGood.goodLatinName,
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
          goodsList: _goodsList
            ..remove(oldGood)
            ..insert(
              oldGoodIndex,
              GoodsModel(
                goodId: goodId,
                goodName: editedGood.goodName,
                goodLatinName: editedGood.goodLatinName,
                brandId: editedGood.brandId,
                numInBox: editedGood.numInBox,
                accountingCode: editedGood.accountingCode,
                barcode: editedGood.barcode,
              ),
            ),
          countGoodsList: _countGoodsList,
          lakingList: _lakingList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    }
  }

  void _onEditIncomingList(
      EditIncomingList event, Emitter<AppState> emit) async {
    final int incomeId = event.oldIncomingListId;
    final IncomingListModel oldIncomingList = _incomingList
        .firstWhere((element) => element.incomingListId == incomeId);

    final IncomingListModel editedIncomingList = event.newIncomingListItem;

    final int oldIncomeIndex = _incomingList.indexOf(oldIncomingList);

    if (editedIncomingList.numOfBoxes.toString().isNotEmpty &&
        editedIncomingList.brandId.toString().isNotEmpty &&
        editedIncomingList.incomingListDate.toString().isNotEmpty) {
      await DBHelper.instance.updateIncomingList(
        IncomingListModel(
          incomingListId: incomeId,
          brandId: editedIncomingList.brandId,
          numOfBoxes: editedIncomingList.numOfBoxes,
          incomingListDate: editedIncomingList.incomingListDate,
        ),
      );

      emit(
        DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList
            ..remove(oldIncomingList)
            ..insert(
              oldIncomeIndex,
              IncomingListModel(
                incomingListId: incomeId,
                brandId: editedIncomingList.brandId,
                numOfBoxes: editedIncomingList.numOfBoxes,
                incomingListDate: editedIncomingList.incomingListDate,
              ),
            ),
          goodsList: _goodsList,
          countGoodsList: _countGoodsList,
          lakingList: _lakingList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    }
  }

  void _onDeleteIncomingList(
      DeleteIncomingList event, Emitter<AppState> emit) async {
    final IncomingListModel deletedIncomeItem = event.deleteIncomingListItem;

    final bool isExistIncomingListOnCountGoods = _countGoodsList.isNotEmpty
        ? _countGoodsList.any((element) =>
            element.incomingListId == deletedIncomeItem.incomingListId)
        : false; //! false means it is not exist on count goods list

    if (isExistIncomingListOnCountGoods == true) {
      await DBHelper.instance.deleteCountGoodsOfIncomingList(deletedIncomeItem);
      await DBHelper.instance.deleteIncomingList(deletedIncomeItem);
      emit(
        DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList..remove(deletedIncomeItem),
          goodsList: _goodsList,
          countGoodsList: _countGoodsList
            ..removeWhere((element) =>
                element.incomingListId == deletedIncomeItem.incomingListId),
          lakingList: _lakingList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    } else {
      await DBHelper.instance.deleteIncomingList(deletedIncomeItem);
      emit(
        DisplayAppState(
          brandsList: _brandsList,
          incomingList: _incomingList..remove(deletedIncomeItem),
          goodsList: _goodsList,
          countGoodsList: _countGoodsList,
          lakingList: _lakingList,
          failureMessage: _failureMessage,
          successMessage: _successMessage,
        ),
      );
    }
  }
}
