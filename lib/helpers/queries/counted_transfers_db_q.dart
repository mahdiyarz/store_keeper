import '../../models/counted_transfers_model.dart';
import '../db_helper.dart';

class CountedTransferQueries {
  static final CountedTransferQueries instance = CountedTransferQueries._init();
  CountedTransferQueries._init();

  Future<CountedTransfersModel> insertData(
      CountedTransfersModel countedTransfersModel) async {
    final db = await DBHelper.instance.database;
    final id =
        await db.insert(countedTransfersTable, countedTransfersModel.toMap());

    return countedTransfersModel.copyWith(id: id);
  }

  Future<List<CountedTransfersModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${CountedTransfersFields.id} ASC';
    final fetchResult = await db.query(countedTransfersTable, orderBy: orderBy);

    return fetchResult.map((e) => CountedTransfersModel.fromMap(e)).toList();
  }

  Future<CountedTransfersModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      countedTransfersTable,
      columns: CountedTransfersFields.values,
      where: '${CountedTransfersFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return CountedTransfersModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(CountedTransfersModel countedTransfersModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      countedTransfersTable,
      countedTransfersModel.toMap(),
      where: '${CountedTransfersFields.id} = ?',
      whereArgs: [countedTransfersModel.id],
    );
  }

  Future<int> deleteData(CountedTransfersModel countedTransfersModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      countedTransfersTable,
      where: '${CountedTransfersFields.id} = ?',
      whereArgs: [countedTransfersModel.id],
    );
  }
}
