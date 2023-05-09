import '../../models/outputs_model.dart';
import '../db_helper.dart';

class OutputsQueries {
  static final OutputsQueries instance = OutputsQueries._init();
  OutputsQueries._init();

  Future<OutputsModel> insertData(OutputsModel outputsModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(outputsTable, outputsModel.toMap());

    return outputsModel.copyWith(id: id);
  }

  Future<List<OutputsModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${OutputsFields.date} ASC';
    final fetchResult = await db.query(outputsTable, orderBy: orderBy);

    return fetchResult.map((e) => OutputsModel.fromMap(e)).toList();
  }

  Future<OutputsModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      outputsTable,
      columns: OutputsFields.values,
      where: '${OutputsFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return OutputsModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(OutputsModel outputsModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      outputsTable,
      outputsModel.toMap(),
      where: '${OutputsFields.id} = ?',
      whereArgs: [outputsModel.id],
    );
  }

  Future<int> deleteData(OutputsModel outputsModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      outputsTable,
      where: '${OutputsFields.id} = ?',
      whereArgs: [outputsModel.id],
    );
  }
}
