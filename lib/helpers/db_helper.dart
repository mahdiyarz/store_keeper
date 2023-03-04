import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart' as pathPackage;

import '../models/import_models.dart';
import '../models/persons_model.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static sqflite.Database? _database;

  DBHelper._init();

  Future<sqflite.Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('store_database.db');
    return _database!;
  }

  Future<sqflite.Database> _initDB(String dbName) async {
    final dbPath = await sqflite.getDatabasesPath();
    final path = pathPackage.join(dbPath, dbName);
    // await sqflite.deleteDatabase(path);

    return await sqflite.openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(sqflite.Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypeNull = 'TEXT';
    const intType = 'INTEGER NOT NULL';
    const intTypeNull = 'INTEGER';
    // const boolType = 'BOOLEAN NOT NULL';
    // const boolTypeNull = 'BOOLEAN';

    await db.execute('''
      CREATE TABLE $incomingListTable(
        ${IncomingListFields.incomingListId} $idType,
        ${IncomingListFields.brandId} $intType,
        ${IncomingListFields.numOfBoxes} $intType,
        ${IncomingListFields.incomingListDate}  $textType      
      )
     ''');

    await db.execute('''
      CREATE TABLE $brandsTable(
        ${BrandsFields.brandId} $idType,
        ${BrandsFields.brandName}  $textType,        
        ${BrandsFields.brandLatinName} $textType   
      )
     ''');

    await db.execute('''
      CREATE TABLE $countGoodsTable(
        ${CountGoodsFields.countGoodsId} $idType,
        ${CountGoodsFields.numOfBox} $intTypeNull,
        ${CountGoodsFields.numOfSeed} $intTypeNull,
        ${CountGoodsFields.price}  $intTypeNull, 
        ${CountGoodsFields.goodsId} $intType,
        ${CountGoodsFields.incomingListId} $intTypeNull,
        ${CountGoodsFields.lakingId} $intTypeNull      
      )
     ''');

    await db.execute('''
      CREATE TABLE $goodsTable(
        ${GoodsFields.goodId} $idType,
        ${GoodsFields.goodName} $textType,
        ${GoodsFields.goodLatinName} $textType,
        ${GoodsFields.brandId} $intType,
        ${GoodsFields.numInBox}  $intType,
        ${GoodsFields.barcode} $intTypeNull,      
        ${GoodsFields.accountingCode} $intTypeNull      
      )
     ''');

    await db.execute('''
      CREATE TABLE $lakingTable(
        ${LakingFields.lakingId} $idType,
        ${LakingFields.lakingDate}  $textType,      
        ${LakingFields.lakingNum} $intType
      )
     ''');

    await db.execute('''
      CREATE TABLE $personsTable(
        ${PersonsFields.personId} $idType,
        ${PersonsFields.personName}  $textType,      
        ${PersonsFields.personDescription} $textTypeNull
      )
     ''');
  }

  Future closeDB() async {
    final db = await instance.database;

    db.close();
  }

  //* Incoming List Logics

  Future<IncomingListModel> insertIncomingList(
      IncomingListModel incomingListModel) async {
    final db = await instance.database;
    final id = await db.insert(incomingListTable, incomingListModel.toJson());

    return incomingListModel.copy(incomingListId: id);
  }

  Future<List<IncomingListModel>> fetchIncomingListData() async {
    final db = await instance.database;
    const orderBy = '${IncomingListFields.incomingListDate} ASC';
    final fetchResult = await db.query(incomingListTable, orderBy: orderBy);

    return fetchResult.map((e) => IncomingListModel.fromJson(e)).toList();
  }

  Future<IncomingListModel> fetchSingleIncomingGoodData(
      int incomingListId) async {
    final db = await instance.database;

    final fetchResult = await db.query(
      incomingListTable,
      columns: IncomingListFields.values,
      where: '${IncomingListFields.incomingListId} = ?',
      whereArgs: [incomingListId],
    );

    if (fetchResult.isNotEmpty) {
      return IncomingListModel.fromJson(fetchResult.first);
    } else {
      throw Exception('ID $incomingListId not found');
    }
  }

  Future<int> updateIncomingList(IncomingListModel incomingListModel) async {
    final db = await instance.database;

    return db.update(
      incomingListTable,
      incomingListModel.toJson(),
      where: '${IncomingListFields.incomingListId} = ?',
      whereArgs: [incomingListModel.incomingListId],
    );
  }

  Future<int> deleteIncomingList(IncomingListModel incomingListModel) async {
    final db = await instance.database;
    return db.delete(
      incomingListTable,
      where: '${IncomingListFields.incomingListId} = ?',
      whereArgs: [incomingListModel.incomingListId],
    );
  }

  //* Brands Logics

  Future<BrandsModel> insertBrands(BrandsModel brandsModel) async {
    final db = await instance.database;
    final result = await db.insert(brandsTable, brandsModel.toJson());

    return brandsModel.copy(brandId: result);
  }

  Future<List<BrandsModel>> fetchBrandsData() async {
    final db = await instance.database;
    const orderBy = '${BrandsFields.brandName} ASC';
    final fetchResult = await db.query(brandsTable, orderBy: orderBy);

    return fetchResult.map((e) => BrandsModel.fromJson(e)).toList();
  }

  Future<BrandsModel> fetchSingleBrandData(int brandsId) async {
    final db = await instance.database;

    final fetchResult = await db.query(
      brandsTable,
      columns: BrandsFields.values,
      where: '${BrandsFields.brandId} = ?',
      whereArgs: [brandsId],
    );

    if (fetchResult.isNotEmpty) {
      return BrandsModel.fromJson(fetchResult.first);
    } else {
      throw Exception('ID $brandsId not found');
    }
  }

  Future<int> updateBrands(BrandsModel brandsModel) async {
    final db = await instance.database;

    return db.update(
      brandsTable,
      brandsModel.toJson(),
      where: '${BrandsFields.brandId} = ?',
      whereArgs: [brandsModel.brandId],
    );
  }

  Future<int> deleteBrands(BrandsModel brandsModel) async {
    final db = await instance.database;
    return db.delete(
      brandsTable,
      where: '${BrandsFields.brandId} = ?',
      whereArgs: [brandsModel.brandId],
    );
  }

  //* Count Goods Logics

  Future<CountGoodsModel> insertCountGoods(
      CountGoodsModel countGoodsModel) async {
    final db = await instance.database;
    final id = await db.insert(countGoodsTable, countGoodsModel.toJson());

    return countGoodsModel.copy(countGoodsId: id);
  }

  Future<List<CountGoodsModel>> fetchCountGoodsData() async {
    final db = await instance.database;
    const orderBy = '${CountGoodsFields.countGoodsId} ASC';
    final fetchResult = await db.query(countGoodsTable, orderBy: orderBy);

    return fetchResult.map((e) => CountGoodsModel.fromJson(e)).toList();
  }

  Future<int> deleteCountGoods(CountGoodsModel countGoodsModel) async {
    final db = await instance.database;
    return db.delete(
      countGoodsTable,
      where: '${CountGoodsFields.countGoodsId} = ?',
      whereArgs: [countGoodsModel.countGoodsId],
    );
  }

  Future<int> deleteCountGoodsOfIncomingList(
      IncomingListModel incomingListModel) async {
    final db = await instance.database;
    return db.delete(
      countGoodsTable,
      where: '${CountGoodsFields.incomingListId} = ?',
      whereArgs: [incomingListModel.incomingListId],
    );
  }

  //* Goods Logics

  Future<GoodsModel> insertGoods(GoodsModel goodsModel) async {
    final db = await instance.database;
    final id = await db.insert(goodsTable, goodsModel.toJson());

    return goodsModel.copy(goodId: id);
  }

  Future<List<GoodsModel>> fetchGoodsData() async {
    final db = await instance.database;
    const orderBy = '${GoodsFields.goodName} ASC';
    final fetchResult = await db.query(goodsTable, orderBy: orderBy);

    return fetchResult.map((e) => GoodsModel.fromJson(e)).toList();
  }

  Future<int> deleteGoods(GoodsModel goodsModel) async {
    final db = await instance.database;
    return db.delete(
      goodsTable,
      where: '${GoodsFields.goodId} = ?',
      whereArgs: [goodsModel.goodId],
    );
  }

  Future<int> updateGoods(GoodsModel goodsModel) async {
    final db = await instance.database;

    return db.update(
      goodsTable,
      goodsModel.toJson(),
      where: '${GoodsFields.goodId} = ?',
      whereArgs: [goodsModel.goodId],
    );
  }

  //* Laking Logics

  Future<LakingModel> insertLaking(LakingModel lakingModel) async {
    final db = await instance.database;
    final id = await db.insert(lakingTable, lakingModel.toJson());

    return lakingModel.copy(lakingId: id);
  }

  Future<List<LakingModel>> fetchLakingData() async {
    final db = await instance.database;
    const orderBy = '${LakingFields.lakingDate} ASC';
    final fetchResult = await db.query(lakingTable, orderBy: orderBy);

    return fetchResult.map((e) => LakingModel.fromJson(e)).toList();
  }

  Future<int> deleteLaking(LakingModel lakingModel) async {
    final db = await instance.database;
    return db.delete(
      lakingTable,
      where: '${LakingFields.lakingId} = ?',
      whereArgs: [lakingModel.lakingId],
    );
  }

  //* Persons CRUD queries
  Future<PersonsModel> insertPersons(PersonsModel personsModel) async {
    final db = await instance.database;
    final result = await db.insert(personsTable, personsModel.toJson());

    return personsModel.copyWith(personId: result);
  }

  Future<List<PersonsModel>> fetchPersonsData() async {
    final db = await instance.database;
    const orderBy = '${PersonsFields.personName} ASC';
    final fetchResult = await db.query(personsTable, orderBy: orderBy);

    return fetchResult.map((e) => PersonsModel.fromJson(e)).toList();
  }

  Future<PersonsModel> fetchSinglePersonData(int personId) async {
    final db = await instance.database;

    final fetchResult = await db.query(
      personsTable,
      columns: PersonsFields.values,
      where: '${PersonsFields.personId} = ?',
      whereArgs: [personId],
    );

    if (fetchResult.isNotEmpty) {
      return PersonsModel.fromJson(fetchResult.first);
    } else {
      throw Exception('ID $personId not found');
    }
  }

  Future<int> updatePersons(PersonsModel personsModel) async {
    final db = await instance.database;

    return db.update(
      personsTable,
      personsModel.toJson(),
      where: '${PersonsFields.personId} = ?',
      whereArgs: [personsModel.personId],
    );
  }

  Future<int> deletePersons(PersonsModel personsModel) async {
    final db = await instance.database;
    return db.delete(
      personsTable,
      where: '${PersonsFields.personId} = ?',
      whereArgs: [personsModel.personId],
    );
  }
}
