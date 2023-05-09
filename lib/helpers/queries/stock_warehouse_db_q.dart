import '../../models/stock_each_warehouse_model.dart';
import '../db_helper.dart';

class StockEachWarehouseQueries {
  static final StockEachWarehouseQueries instance =
      StockEachWarehouseQueries._init();
  StockEachWarehouseQueries._init();

  Future<StockEachWarehouseModel> insertData(
      StockEachWarehouseModel stockEachWarehouseModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(
        stockEachWarehouseTable, stockEachWarehouseModel.toMap());

    return stockEachWarehouseModel.copyWith(id: id);
  }

  Future<List<StockEachWarehouseModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${StockEachWarehouseFields.date} ASC';
    final fetchResult =
        await db.query(stockEachWarehouseTable, orderBy: orderBy);

    return fetchResult.map((e) => StockEachWarehouseModel.fromMap(e)).toList();
  }

  Future<StockEachWarehouseModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      stockEachWarehouseTable,
      columns: StockEachWarehouseFields.values,
      where: '${StockEachWarehouseFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return StockEachWarehouseModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(
      StockEachWarehouseModel stockEachWarehouseModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      stockEachWarehouseTable,
      stockEachWarehouseModel.toMap(),
      where: '${StockEachWarehouseFields.id} = ?',
      whereArgs: [stockEachWarehouseModel.id],
    );
  }

  Future<int> deleteData(
      StockEachWarehouseModel stockEachWarehouseModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      stockEachWarehouseTable,
      where: '${StockEachWarehouseFields.id} = ?',
      whereArgs: [stockEachWarehouseModel.id],
    );
  }
}
