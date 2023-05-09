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
        ${BrandsFields.id} $idType,
        ${BrandsFields.name}  $textType,        
        ${BrandsFields.latin} $textType   
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
        ${CountGoodsFields.id} $idType,
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
        ${GoodsFields.id} $idType,
        ${GoodsFields.name} $textType,
        ${GoodsFields.latin} $textType,
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
        ${PersonsFields.id} $idType,
        ${PersonsFields.name}  $textType,      
        ${PersonsFields.description} $textTypeNull
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
}
