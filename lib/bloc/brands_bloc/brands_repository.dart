import 'package:flutter/cupertino.dart';
import 'package:store_keeper/helpers/db_helper.dart';
import 'package:store_keeper/models/brands_model.dart';

abstract class BrandsRepository {
  Future<List<BrandsModel>> getBrands();
  Future<BrandsModel> loadSingleBrand({@required int id});
  Future<int> updateBrand({@required BrandsModel brand});
  Future<int> addBrand({@required BrandsModel brand});
  Future<int> deleteBrand({@required BrandsModel brand});
}

class BrandsRepositoryImplement extends BrandsRepository {
  @override
  Future<int> addBrand({BrandsModel? brand}) async {
    final int response = await DBHelper.instance.insertBrands(brand!);
    return response;
  }

  @override
  Future<int> deleteBrand({BrandsModel? brand}) async {
    final int response = await DBHelper.instance.deleteBrands(brand!);
    return response;
  }

  @override
  Future<List<BrandsModel>> getBrands() async {
    final List<BrandsModel> brands = await DBHelper.instance.fetchBrandsData();
    return brands;
  }

  @override
  Future<BrandsModel> loadSingleBrand({int? id}) async {
    final BrandsModel brand = await DBHelper.instance.fetchSingleBrandData(id!);
    return brand;
  }

  @override
  Future<int> updateBrand({BrandsModel? brand}) async {
    final int response = await DBHelper.instance.updateBrands(brand!);
    return response;
  }
}
