import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/import_models.dart';

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
      CREATE TABLE $incomingsTable(
        ${IncomingsFields.incomingId} $idType,
        ${IncomingsFields.personId} $intType,
        ${IncomingsFields.boxes} $intType,
        ${IncomingsFields.incomingDate}  $textType      
      )
     ''');

    await db.execute('''
      CREATE TABLE $outputsTable(
        ${OutputsFields.id} $idType,
        ${OutputsFields.personId} $intType,
        ${OutputsFields.date}  $textType      
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
      CREATE TABLE $stockTable(
        ${StockFields.id} $idType,
        ${StockFields.goodId} $intType,
        ${StockFields.countedIncomingId} $intTypeNull,
        ${StockFields.countedOutputId} $intTypeNull,
        ${StockFields.date} $textType,
        ${StockFields.totalStock}  $intType      
      )
     ''');

    await db.execute('''
      CREATE TABLE $stockEachWarehouseTable(
        ${StockEachWarehouseFields.id} $idType,
        ${StockEachWarehouseFields.goodId} $intType,
        ${StockEachWarehouseFields.warehouseId}  $intType,      
        ${StockEachWarehouseFields.countedIncomingId}  $intTypeNull,      
        ${StockEachWarehouseFields.countedOutputId}  $intTypeNull,      
        ${StockEachWarehouseFields.date}  $textType,      
        ${StockEachWarehouseFields.totalStock}  $intType      
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

    await db.execute('''
      CREATE TABLE $warehousesTable(
        ${WarehousesFields.id} $idType,
        ${WarehousesFields.name} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $transfersTable(
        ${TransfersField.id} $idType,
        ${TransfersField.personId} $intType,
        ${TransfersField.boxes} $intType,
        ${TransfersField.date} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $warehouseHandlingTable(
        ${WarehouseHandlingFields.id} $idType,
        ${WarehouseHandlingFields.warehouseId} $intType,
        ${WarehouseHandlingFields.countNumber} $intType,
        ${WarehouseHandlingFields.date} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $countedWarehouseHandlingTable(
        ${CountedWarehouseHandlingFields.id} $idType,
        ${CountedWarehouseHandlingFields.warehouseHandlingId} $intType,
        ${CountedWarehouseHandlingFields.goodId} $intType,
        ${CountedWarehouseHandlingFields.withBoxes} $intTypeNull,
        ${CountedWarehouseHandlingFields.withoutBox} $intType,
        ${CountedWarehouseHandlingFields.totalCounted} $intType
      )
    ''');

    await db.execute('''
      CREATE TABLE $countedOutputsTable(
        ${CountedOutputsFields.id} $idType,
        ${CountedOutputsFields.outputId} $intType,
        ${CountedOutputsFields.goodId} $intType,
        ${CountedOutputsFields.warehouseId} $intType,
        ${CountedOutputsFields.withBoxes} $intTypeNull,
        ${CountedOutputsFields.withoutBox} $intType,
        ${CountedOutputsFields.price} $intTypeNull,
        ${CountedOutputsFields.totalCounted} $intType
      )
    ''');

    await db.execute('''
      CREATE TABLE $countedTransfersTable(
        ${CountedTransfersFields.id} $idType,
        ${CountedTransfersFields.transferId} $intType,
        ${CountedTransfersFields.goodId} $intType,
        ${CountedTransfersFields.withBoxes} $intTypeNull,
        ${CountedTransfersFields.withoutBox} $intType,
        ${CountedTransfersFields.totalCounted} $intType
      )
    ''');

    await db.execute('''
      CREATE TABLE $countedIncomingsTable(
        ${CountedIncomingsFields.id} $idType,
        ${CountedIncomingsFields.incomingsId} $intType,
        ${CountedIncomingsFields.goodId} $intType,
        ${CountedIncomingsFields.warehouseId} $intType,
        ${CountedIncomingsFields.withBoxes} $intTypeNull,
        ${CountedIncomingsFields.withoutBox} $intType,
        ${CountedIncomingsFields.price} $intTypeNull,
        ${CountedIncomingsFields.totalCounted} $intType
      )
    ''');
  }

  Future closeDB() async {
    final db = await instance.database;

    db.close();
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
      IncomingsModel incomingListModel) async {
    final db = await instance.database;
    return db.delete(
      countGoodsTable,
      where: '${CountGoodsFields.incomingListId} = ?',
      whereArgs: [incomingListModel.incomingId],
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
