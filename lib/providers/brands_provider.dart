import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';
import '../models/brands_model.dart';

class BrandsProvider with ChangeNotifier {
  List<BrandsModel> _brandsItems = [];
  List<BrandsModel> get brandsItems {
    return [..._brandsItems];
  }

  Future<void> fetchData() async {
    final db = await DBHelper.instance.fetchBrandsData();
    _brandsItems = db;

    notifyListeners();
  }

  Future<BrandsModel> findById(int id) async {
    return await DBHelper.instance.fetchSingleBrandData(id);
  }

  Future<void> updateData(BrandsModel brandsModel) async {
    if (brandsModel.brandName.isNotEmpty) {
      await DBHelper.instance.updateBrands(brandsModel);
      final fetchData = await DBHelper.instance.fetchBrandsData();
      _brandsItems = fetchData;
    }
    notifyListeners();
  }

  Future<void> insertData(BrandsModel brandsModel) async {
    final db = await DBHelper.instance.fetchBrandsData()
      ..map((e) => e.brandName).toList();

    if (db.isEmpty && brandsModel.brandName.isNotEmpty) {
      await DBHelper.instance.insertBrands(brandsModel);
      final fetchData = await DBHelper.instance.fetchBrandsData();
      _brandsItems = fetchData;
      notifyListeners();
    } else {
      final duplicateCheck =
          db.where((element) => element.brandName == brandsModel.brandName);
      if (duplicateCheck.isEmpty && brandsModel.brandName.isNotEmpty) {
        await DBHelper.instance.insertBrands(brandsModel);
        final fetchData = await DBHelper.instance.fetchBrandsData();
        _brandsItems = fetchData;
        notifyListeners();
      } else {
        return;
      }
    }

    notifyListeners();
  }
}
