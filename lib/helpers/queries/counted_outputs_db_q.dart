import '../../models/counted_output_model.dart';
import '../db_helper.dart';

class CountedOutputsQueries {
  static final CountedOutputsQueries instance = CountedOutputsQueries._init();
  CountedOutputsQueries._init();

  Future<CountedOutputsModel> insertData(
      CountedOutputsModel countedOutputsModel) async {
    final db = await DBHelper.instance.database;
    final id =
        await db.insert(countedOutputsTable, countedOutputsModel.toMap());

    return countedOutputsModel.copyWith(id: id);
  }

  Future<List<CountedOutputsModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${CountedOutputsFields.id} ASC';
    final fetchResult = await db.query(countedOutputsTable, orderBy: orderBy);

    return fetchResult.map((e) => CountedOutputsModel.fromMap(e)).toList();
  }

  Future<CountedOutputsModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      countedOutputsTable,
      columns: CountedOutputsFields.values,
      where: '${CountedOutputsFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return CountedOutputsModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(CountedOutputsModel countedOutputsModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      countedOutputsTable,
      countedOutputsModel.toMap(),
      where: '${CountedOutputsFields.id} = ?',
      whereArgs: [countedOutputsModel.id],
    );
  }

  Future<int> deleteData(CountedOutputsModel countedOutputsModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      countedOutputsTable,
      where: '${CountedOutputsFields.id} = ?',
      whereArgs: [countedOutputsModel.id],
    );
  }
}
