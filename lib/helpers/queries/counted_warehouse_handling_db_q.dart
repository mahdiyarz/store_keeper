import '../../models/counted_warehouse_handling_model.dart';
import '../db_helper.dart';

class CountedWarehouseHandlingQueries {
  static final CountedWarehouseHandlingQueries instance =
      CountedWarehouseHandlingQueries._init();
  CountedWarehouseHandlingQueries._init();

  Future<CountedWarehouseHandlingModel> insertData(
      CountedWarehouseHandlingModel countedWarehouseHandlingModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(
        countedWarehouseHandlingTable, countedWarehouseHandlingModel.toMap());

    return countedWarehouseHandlingModel.copyWith(id: id);
  }

  Future<List<CountedWarehouseHandlingModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${CountedWarehouseHandlingFields.id} ASC';
    final fetchResult =
        await db.query(countedWarehouseHandlingTable, orderBy: orderBy);

    return fetchResult
        .map((e) => CountedWarehouseHandlingModel.fromMap(e))
        .toList();
  }

  Future<CountedWarehouseHandlingModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      countedWarehouseHandlingTable,
      columns: CountedWarehouseHandlingFields.values,
      where: '${CountedWarehouseHandlingFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return CountedWarehouseHandlingModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(
      CountedWarehouseHandlingModel countedWarehouseHandlingModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      countedWarehouseHandlingTable,
      countedWarehouseHandlingModel.toMap(),
      where: '${CountedWarehouseHandlingFields.id} = ?',
      whereArgs: [countedWarehouseHandlingModel.id],
    );
  }

  Future<int> deleteData(
      CountedWarehouseHandlingModel countedWarehouseHandlingModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      countedWarehouseHandlingTable,
      where: '${CountedWarehouseHandlingFields.id} = ?',
      whereArgs: [countedWarehouseHandlingModel.id],
    );
  }
}
