import '../../models/stock_model.dart';
import '../db_helper.dart';

class StockQueries {
  static final StockQueries instance = StockQueries._init();
  StockQueries._init();

  Future<StockModel> insertData(StockModel stockModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(stockTable, stockModel.toMap());

    return stockModel.copyWith(id: id);
  }

  Future<List<StockModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${StockFields.date} ASC';
    final fetchResult = await db.query(stockTable, orderBy: orderBy);

    return fetchResult.map((e) => StockModel.fromMap(e)).toList();
  }

  Future<StockModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      stockTable,
      columns: StockFields.values,
      where: '${StockFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return StockModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(StockModel stockModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      stockTable,
      stockModel.toMap(),
      where: '${StockFields.id} = ?',
      whereArgs: [stockModel.id],
    );
  }

  Future<int> deleteData(StockModel stockModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      stockTable,
      where: '${StockFields.id} = ?',
      whereArgs: [stockModel.id],
    );
  }
}
