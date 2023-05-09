import '../../models/incomings_model.dart';
import '../db_helper.dart';

class IncomingsQueries {
  static final IncomingsQueries instance = IncomingsQueries._init();
  IncomingsQueries._init();

  Future<IncomingsModel> insertData(IncomingsModel incomingListModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(incomingsTable, incomingListModel.toJson());

    return incomingListModel.copy(incomingId: id);
  }

  Future<List<IncomingsModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${IncomingsFields.incomingDate} ASC';
    final fetchResult = await db.query(incomingsTable, orderBy: orderBy);

    return fetchResult.map((e) => IncomingsModel.fromJson(e)).toList();
  }

  Future<IncomingsModel> fetchSingleData(int incomingId) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      incomingsTable,
      columns: IncomingsFields.values,
      where: '${IncomingsFields.incomingId} = ?',
      whereArgs: [incomingId],
    );

    if (fetchResult.isNotEmpty) {
      return IncomingsModel.fromJson(fetchResult.first);
    } else {
      throw Exception('ID $incomingId not found');
    }
  }

  Future<int> updateData(IncomingsModel incomingListModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      incomingsTable,
      incomingListModel.toJson(),
      where: '${IncomingsFields.incomingId} = ?',
      whereArgs: [incomingListModel.incomingId],
    );
  }

  Future<int> deleteData(IncomingsModel incomingListModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      incomingsTable,
      where: '${IncomingsFields.incomingId} = ?',
      whereArgs: [incomingListModel.incomingId],
    );
  }
}
