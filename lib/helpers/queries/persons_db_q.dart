import '../../models/persons_model.dart';
import '../db_helper.dart';

class PersonsQueries {
  static final PersonsQueries instance = PersonsQueries._init();
  PersonsQueries._init();

  Future<PersonsModel> insertData(PersonsModel personsModel) async {
    final db = await DBHelper.instance.database;
    final id = await db.insert(personsTable, personsModel.toMap());

    return personsModel.copyWith(id: id);
  }

  Future<List<PersonsModel>> fetchAllData() async {
    final db = await DBHelper.instance.database;
    const orderBy = '${PersonsFields.name} ASC';
    final fetchResult = await db.query(personsTable, orderBy: orderBy);

    return fetchResult.map((e) => PersonsModel.fromMap(e)).toList();
  }

  Future<PersonsModel> fetchSingleData(int id) async {
    final db = await DBHelper.instance.database;

    final fetchResult = await db.query(
      personsTable,
      columns: PersonsFields.values,
      where: '${PersonsFields.id} = ?',
      whereArgs: [id],
    );

    if (fetchResult.isNotEmpty) {
      return PersonsModel.fromMap(fetchResult.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(PersonsModel personsModel) async {
    final db = await DBHelper.instance.database;

    return db.update(
      personsTable,
      personsModel.toMap(),
      where: '${PersonsFields.id} = ?',
      whereArgs: [personsModel.id],
    );
  }

  Future<int> deleteData(PersonsModel personsModel) async {
    final db = await DBHelper.instance.database;
    return db.delete(
      personsTable,
      where: '${PersonsFields.id} = ?',
      whereArgs: [personsModel.id],
    );
  }
}
