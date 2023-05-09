import '../../models/transfers_model.dart';
import '../db_helper.dart';

class TransfersQueries {
  static final TransfersQueries instance = TransfersQueries._init();
  TransfersQueries._init();

  Future<TransfersModel> insertData(TransfersModel transfersModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(transfersTable, transfersModel.toMap());

    return transfersModel.copyWith(id: id);
  }

  Future<List<TransfersModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${TransfersField.date} ASC';
    final fetchResult = await db.query(transfersTable, orderBy: orderBy);

    return fetchResult.map((e) => TransfersModel.fromMap(e)).toList();
  }

  Future<TransfersModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      transfersTable,
      columns: TransfersField.values,
      where: '${TransfersField.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return TransfersModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(TransfersModel transfersModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      transfersTable,
      transfersModel.toMap(),
      where: '${TransfersField.id} = ?',
      whereArgs: [transfersModel.id],
    );
  }

  Future<int> deleteData(TransfersModel transfersModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      transfersTable,
      where: '${TransfersField.id} = ?',
      whereArgs: [transfersModel.id],
    );
  }
}
