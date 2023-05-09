import '../../models/goods_model.dart';
import '../db_helper.dart';

class GoodsQueries {
  static final GoodsQueries instance = GoodsQueries._init();
  GoodsQueries._init();

  Future<GoodsModel> insertData(GoodsModel goodsModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(goodsTable, goodsModel.toMap());

    return goodsModel.copyWith(id: id);
  }

  Future<List<GoodsModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${GoodsFields.name} ASC';
    final fetchResult = await db.query(goodsTable, orderBy: orderBy);

    return fetchResult.map((e) => GoodsModel.fromMap(e)).toList();
  }

  Future<GoodsModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      goodsTable,
      columns: GoodsFields.values,
      where: '${GoodsFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return GoodsModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(GoodsModel goodsModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      goodsTable,
      goodsModel.toMap(),
      where: '${GoodsFields.id} = ?',
      whereArgs: [goodsModel.id],
    );
  }

  Future<int> deleteData(GoodsModel goodsModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      goodsTable,
      where: '${GoodsFields.id} = ?',
      whereArgs: [goodsModel.id],
    );
  }
}
