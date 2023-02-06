import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/helpers/db_helper.dart';

import '../../models/brands_model.dart';

part 'brands_event.dart';
part 'brands_state.dart';

// class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
//   final BrandsRepository repository;

//   BrandsBloc({
//     required this.repository,
//   }) : super(const BrandsState.empty());

//   @override
//   Stream<BrandsState> mapEventToState(BrandsEvent event) async* {
//     final currentState = state;

//     if (event is ShowBrands) {
//       yield* _mapShowBrandsToEvent(event, currentState);
//     }

//     if (event is AddBrand) {
//       yield* _mapAddBrandToEvent(event, currentState);
//     }
//   }

//   Stream<BrandsState> _mapShowBrandsToEvent(
//       ShowBrands event, BrandsState currentState) async* {
//     try {
//       final List<BrandsModel> brandsList = await repository.getBrands();
//       yield BrandsState(brandsList: brandsList);
//     } catch (e) {
//       log(e.toString(), time: DateTime.now());
//     }
//   }

//   Stream<BrandsState> _mapAddBrandToEvent(
//       AddBrand event, BrandsState currentState) async* {
//     try {
//       final response = await repository.addBrand(brand: event.brand);
//       if (response == 0) {
//         return;
//       } else {
//         add(const ShowBrands());
//       }
//     } catch (e) {
//       log(e.toString(), time: DateTime.now());
//     }
//   }
// }

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  BrandsBloc() : super(const BrandsStateInitial()) {
    List<BrandsModel> brandsList;

    on<FetchBrands>((event, emit) async {
      log('start FetchBrands on bloc');

      brandsList = await DBHelper.instance.fetchBrandsData();

      emit(
        DisplayBrandsState(
          brandsList: brandsList,
        ),
      );
      log('End FetchBrands on bloc');
    });

    on<AddBrand>(_onAddBrand);
    on<EditBrand>(_onEditBrand);
    on<DeleteBrand>(_onDeleteBrand);
  }
  void _onAddBrand(AddBrand event, Emitter<BrandsState> emit) async {
    log('run AddBrand');

    final brand = event.brand;

    if (brand.brandName.isNotEmpty && brand.brandLatinName.isNotEmpty) {
      await DBHelper.instance.insertBrands(
        BrandsModel(
          brandName: brand.brandName,
          brandLatinName: brand.brandLatinName,
        ),
      );
    }
  }

  void _onEditBrand(EditBrand event, Emitter<BrandsState> emit) async {
    log('Edit Brand process...');

    final oldBrand = event.oldBrand;
    final editedBrand = event.newBrand;

    if (oldBrand.brandName.isNotEmpty && oldBrand.brandLatinName.isNotEmpty) {
      await DBHelper.instance.updateBrands(
        BrandsModel(
          brandId: oldBrand.brandId,
          brandName: editedBrand.brandName,
          brandLatinName: editedBrand.brandLatinName,
        ),
      );
    }
  }

  void _onDeleteBrand(DeleteBrand event, Emitter<BrandsState> emit) async {
    log('DELETING...');

    final deletedBrand = event.brand;

    if (deletedBrand.brandName.isNotEmpty &&
        deletedBrand.brandLatinName.isNotEmpty) {
      await DBHelper.instance.deleteBrands(
        BrandsModel(
          brandId: deletedBrand.brandId,
          brandName: deletedBrand.brandName,
          brandLatinName: deletedBrand.brandLatinName,
        ),
      );
    }
  }
}
