import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';
import '../models/arrival_goods_model.dart';

class ArrivalGoodsProvider with ChangeNotifier {
  List<ArrivalGoodsModel> _arrivalGoodsItems = [];
  List<ArrivalGoodsModel> get arrivalGoodsItems {
    return [..._arrivalGoodsItems];
  }

  Future<void> fetchData() async {
    final db = await DBHelper.instance.fetchArrivalGoodsData();
    _arrivalGoodsItems = db;

    notifyListeners();
  }

  Future<void> insertData(ArrivalGoodsModel arrivalGoodsModel) async {
    await DBHelper.instance.insertArrivalGoods(arrivalGoodsModel);
    final db = await DBHelper.instance.fetchArrivalGoodsData();
    _arrivalGoodsItems = db;

    notifyListeners();
  }
}
