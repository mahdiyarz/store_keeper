import '../../models/warehouse_handling_model.dart';
import '../db_helper.dart';

class WarehouseHandlingQueries {
  static final WarehouseHandlingQueries instance =
      WarehouseHandlingQueries._init();
  WarehouseHandlingQueries._init();

  Future<WarehouseHandlingModel> insertData(
      WarehouseHandlingModel warehouseHandlingModel) async {
    final db = await DBHelper.instance.database;
    final id =
        await db.insert(warehouseHandlingTable, warehouseHandlingModel.toMap());

    return warehouseHandlingModel.copyWith(id: id);
  }

  Future<List<WarehouseHandlingModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${WarehouseHandlingFields.date} ASC';
    final fetchResult =
        await db.query(warehouseHandlingTable, orderBy: orderBy);

    return fetchResult.map((e) => WarehouseHandlingModel.fromMap(e)).toList();
  }

  Future<WarehouseHandlingModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      warehouseHandlingTable,
      columns: WarehouseHandlingFields.values,
      where: '${WarehouseHandlingFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return WarehouseHandlingModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(WarehouseHandlingModel warehouseHandlingModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      warehouseHandlingTable,
      warehouseHandlingModel.toMap(),
      where: '${WarehouseHandlingFields.id} = ?',
      whereArgs: [warehouseHandlingModel.id],
    );
  }

  Future<int> deleteData(WarehouseHandlingModel warehouseHandlingModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      warehouseHandlingTable,
      where: '${WarehouseHandlingFields.id} = ?',
      whereArgs: [warehouseHandlingModel.id],
    );
  }
}
