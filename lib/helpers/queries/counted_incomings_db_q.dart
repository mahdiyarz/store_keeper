import '../../models/counted_incomings_model.dart';
import '../db_helper.dart';

class CountedIncomingsQueries {
  static final CountedIncomingsQueries instance =
      CountedIncomingsQueries._init();
  CountedIncomingsQueries._init();

  Future<CountedIncomingsModel> insertData(
      CountedIncomingsModel countedIncomingsModel) async {
    final db = await DBHelper.instance.database;
    final id =
        await db.insert(countedIncomingsTable, countedIncomingsModel.toJson());

    return countedIncomingsModel.copy(id: id);
  }

  Future<List<CountedIncomingsModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${CountedIncomingsFields.totalCounted} ASC';
    final fetchResult = await db.query(countedIncomingsTable, orderBy: orderBy);

    return fetchResult.map((e) => CountedIncomingsModel.fromJson(e)).toList();
  }

  Future<CountedIncomingsModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      countedIncomingsTable,
      columns: CountedIncomingsFields.values,
      where: '${CountedIncomingsFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return CountedIncomingsModel.fromJson(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(CountedIncomingsModel countedIncomingsModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      countedIncomingsTable,
      countedIncomingsModel.toJson(),
      where: '${CountedIncomingsFields.id} = ?',
      whereArgs: [countedIncomingsModel.id],
    );
  }

  Future<int> deleteData(CountedIncomingsModel countedIncomingsModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      countedIncomingsTable,
      where: '${CountedIncomingsFields.id} = ?',
      whereArgs: [countedIncomingsModel.id],
    );
  }
}
