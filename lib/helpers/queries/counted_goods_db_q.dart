import '../../models/count_goods_model.dart';
import '../../models/incomings_model.dart';
import '../db_helper.dart';

class CountedGoodsQueries {
  static final CountedGoodsQueries instance = CountedGoodsQueries._init();
  CountedGoodsQueries._init();

  Future<CountGoodsModel> insertData(CountGoodsModel countGoodsModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(countGoodsTable, countGoodsModel.toMap());

    return countGoodsModel.copyWith(id: id);
  }

  Future<List<CountGoodsModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${CountGoodsFields.id} ASC';
    final fetchResult = await db.query(countGoodsTable, orderBy: orderBy);

    return fetchResult.map((e) => CountGoodsModel.fromMap(e)).toList();
  }

  Future<CountGoodsModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      countGoodsTable,
      columns: CountGoodsFields.values,
      where: '${CountGoodsFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return CountGoodsModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(CountGoodsModel countGoodsModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      countGoodsTable,
      countGoodsModel.toMap(),
      where: '${CountGoodsFields.id} = ?',
      whereArgs: [countGoodsModel.id],
    );
  }

  Future<int> deleteDataByIncomingList(IncomingsModel incomingListModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      countGoodsTable,
      where: '${CountGoodsFields.incomingListId} = ?',
      whereArgs: [incomingListModel.incomingId],
    );
  }

  Future<int> deleteData(CountGoodsModel countGoodsModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      countGoodsTable,
      where: '${CountGoodsFields.incomingListId} = ?',
      whereArgs: [countGoodsModel.id],
    );
  }
}
