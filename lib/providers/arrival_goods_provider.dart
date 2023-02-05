// import 'package:flutter/material.dart';

// import '../helpers/db_helper.dart';
// import '../models/incoming_goods_model.dart';

// class ArrivalGoodsProvider with ChangeNotifier {
//   List<IncomingGoodsModel> _arrivalGoodsItems = [];
//   List<IncomingGoodsModel> get arrivalGoodsItems {
//     return [..._arrivalGoodsItems];
//   }

//   Future<void> fetchData() async {
//     final db = await DBHelper.instance.fetchArrivalGoodsData();
//     _arrivalGoodsItems = db;

//     notifyListeners();
//   }

//   Future<void> insertData(IncomingGoodsModel arrivalGoodsModel) async {
//     await DBHelper.instance.insertArrivalGoods(arrivalGoodsModel);
//     final db = await DBHelper.instance.fetchArrivalGoodsData();
//     _arrivalGoodsItems = db;

//     notifyListeners();
//   }
// }
