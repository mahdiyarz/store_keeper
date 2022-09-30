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

  Future<void> insertData(BrandsModel brandsModel) async {
    final db = await DBHelper.instance.fetchBrandsData()
      ..map((e) => e.brandName).toList();

    if (db.isEmpty) {
      await DBHelper.instance.insertBrands(brandsModel);
      final fetchData = await DBHelper.instance.fetchBrandsData();
      _brandsItems = fetchData;
      notifyListeners();
    } else {
      final duplicateCheck =
          db.where((element) => element.brandName == brandsModel.brandName);
      if (duplicateCheck.isNotEmpty) {
        return;
      } else {
        await DBHelper.instance.insertBrands(brandsModel);
        final fetchData = await DBHelper.instance.fetchBrandsData();
        _brandsItems = fetchData;
        notifyListeners();
      }
    }

    _brandsItems = db;

    notifyListeners();
  }
}
