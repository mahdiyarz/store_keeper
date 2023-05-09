import '../../models/brands_model.dart';
import '../db_helper.dart';

class BrandsQueries {
  static final BrandsQueries instance = BrandsQueries._init();
  BrandsQueries._init();

  Future<BrandsModel> insertData(BrandsModel brandsModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(brandsTable, brandsModel.toMap());

    return brandsModel.copyWith(id: id);
  }

  Future<List<BrandsModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${BrandsFields.name} ASC';
    final fetchResult = await db.query(brandsTable, orderBy: orderBy);

    return fetchResult.map((e) => BrandsModel.fromMap(e)).toList();
  }

  Future<BrandsModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      brandsTable,
      columns: BrandsFields.values,
      where: '${BrandsFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return BrandsModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(BrandsModel brandsModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      brandsTable,
      brandsModel.toMap(),
      where: '${BrandsFields.id} = ?',
      whereArgs: [brandsModel.id],
    );
  }

  Future<int> deleteData(BrandsModel brandsModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      brandsTable,
      where: '${BrandsFields.id} = ?',
      whereArgs: [brandsModel.id],
    );
  }
}
