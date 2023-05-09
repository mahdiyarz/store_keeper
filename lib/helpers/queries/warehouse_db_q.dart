import '../../models/warehouses_model.dart';
import '../db_helper.dart';

class WarehouseQueries {
  static final WarehouseQueries instance = WarehouseQueries._init();
  WarehouseQueries._init();

  Future<WarehousesModel> insertData(WarehousesModel warehousesModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(warehousesTable, warehousesModel.toMap());

    return warehousesModel.copyWith(id: id);
  }

  Future<List<WarehousesModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${WarehousesFields.name} ASC';
    final fetchResult = await db.query(warehousesTable, orderBy: orderBy);

    return fetchResult.map((e) => WarehousesModel.fromMap(e)).toList();
  }

  Future<WarehousesModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      warehousesTable,
      columns: WarehousesFields.values,
      where: '${WarehousesFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return WarehousesModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(WarehousesModel warehousesModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      warehousesTable,
      warehousesModel.toMap(),
      where: '${WarehousesFields.id} = ?',
      whereArgs: [warehousesModel.id],
    );
  }

  Future<int> deleteData(WarehousesModel warehousesModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      warehousesTable,
      where: '${WarehousesFields.id} = ?',
      whereArgs: [warehousesModel.id],
    );
  }
}
