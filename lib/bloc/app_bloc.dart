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
  late String _failureMessage;
  late String _successMessage;

  AppBloc() : super(const AppStateInitial()) {
    on<FetchEvent>(_onFetchEvent);
    on<AddBrand>(_onAddBrand);
    on<EditBrand>(_onEditBrand);
    on<DeleteBrand>(_onDeleteBrand);
    on<AddIncomingList>(_onAddIncomingList);
    on<AddGood>(_onAddGood);
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

    emit(
      DisplayAppState(
        brandsList: _brandsList,
        incomingList: _incomingList,
        goodsList: _goodsList,
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
    }

    emit(
      DisplayAppState(
        brandsList: _brandsList
          ..remove(oldBrand)
          ..insert(oldBrandIndex, editedBrand),
        incomingList: _incomingList,
        goodsList: _goodsList,
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
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
        failureMessage: _failureMessage,
        successMessage: _successMessage,
      ),
    );
  }
}
