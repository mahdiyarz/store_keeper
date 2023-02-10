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

  AppBloc() : super(const AppStateInitial()) {
    on<FetchEvent>(_onFetchEvent);
    on<AddBrand>(_onAddBrand);
    on<EditBrand>(_onEditBrand);
    on<DeleteBrand>(_onDeleteBrand);
    on<AddIncomingList>(_onAddIncomingList);
  }

  void _onFetchEvent(FetchEvent event, Emitter<AppState> emit) async {
    log('start FetchEVENT on bloc');

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
      ),
    );
    log('End FetchEVENT on bloc');
  }

  void _onAddBrand(AddBrand event, Emitter<AppState> emit) async {
    log('run ADD Brand');

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
        // brandsList: _brandsList..insert(0, brand),
        brandsList: _brandsList
          ..clear()
          ..addAll(lastUpdatedBrands),
        incomingList: _incomingList,
        goodsList: _goodsList,
      ),
    );
  }

  void _onEditBrand(EditBrand event, Emitter<AppState> emit) async {
    log('run EDIT Brand');

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
      ),
    );
  }

  void _onDeleteBrand(DeleteBrand event, Emitter<AppState> emit) async {
    // TODO: fix delete logic
    log('run DELETE Brand');

    final BrandsModel deletedBrand = event.brand;
    final bool isExistBrandOnIncomingList = _incomingList
            .firstWhere((element) => element.brandId == deletedBrand.brandId)
            .toString()
            .isEmpty
        ? true
        : false;
    final bool isExistBrandOnGoods = _goodsList
            .firstWhere((element) => element.brandId == deletedBrand.brandId)
            .toString()
            .isEmpty
        ? true
        : false;

    if (isExistBrandOnIncomingList == true && isExistBrandOnGoods == true) {
      await DBHelper.instance.deleteBrands(
        BrandsModel(
          brandId: deletedBrand.brandId,
          brandName: deletedBrand.brandName,
          brandLatinName: deletedBrand.brandLatinName,
        ),
      );

      emit(
        DisplayAppState(
          brandsList: _brandsList..remove(deletedBrand),
          incomingList: _incomingList,
          goodsList: _goodsList,
        ),
      );
      log('Deleting brand finished');
    }

    log('can not Delete brand');
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
      ),
    );
  }
}
