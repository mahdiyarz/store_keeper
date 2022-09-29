import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart' as pathPackage;

import '../models/arrival_goods_model.dart';
import '../models/brands_model.dart';
import '../models/count_goods_model.dart';
import '../models/goods_model.dart';
import '../models/laking_model.dart';

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

    return await sqflite.openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(sqflite.Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    // const textTypeNull = 'TEXT';
    const intType = 'INTEGER NOT NULL';
    // const intTypeNull = 'INTEGER';
    // const boolType = 'BOOLEAN NOT NULL';
    // const boolTypeNull = 'BOOLEAN';

    db.execute('''
      CREATE TABLE $arrivalGoodsTable(
        ${ArrivalGoodsFields.arrivalGoodsId} $idType,
        ${ArrivalGoodsFields.brandId} $intType,
        ${ArrivalGoodsFields.numOfBoxes} $intType,
        ${ArrivalGoodsFields.arrivalGoodsDate}  $textType      
      )
     ''');

    db.execute('''
      CREATE TABLE $brandsTable(
        ${BrandsFields.brandId} $idType,
        ${BrandsFields.brandName}  $textType      
      )
     ''');

    db.execute('''
      CREATE TABLE $CountGoodsFields(
        ${CountGoodsFields.countGoodsId} $idType,
        ${CountGoodsFields.numOfBox} $intType,
        ${CountGoodsFields.numOfSeed} $intType,
        ${CountGoodsFields.price}  $intType,
        ${CountGoodsFields.goodsId} $intType,
        ${CountGoodsFields.arrivalGoodsId} $intType,
        ${CountGoodsFields.lakingId} $intType      
      )
     ''');

    db.execute('''
      CREATE TABLE $goodsTable(
        ${GoodsFields.goodId} $idType,
        ${GoodsFields.goodName} $textType,
        ${GoodsFields.brandId} $intType,
        ${GoodsFields.numInBox}  $intType,
        ${GoodsFields.barcode} $intType      
      )
     ''');

    db.execute('''
      CREATE TABLE $lakingTable(
        ${LakingFields.lakingId} $idType,
        ${LakingFields.lakingDate}  $textType,      
        ${LakingFields.lakingNum} $intType
      )
     ''');
  }

  //* Arrival Goods Logics

  Future<ArrivalGoodsModel> insertArrivalGoods(
      ArrivalGoodsModel arrivalGoodsModel) async {
    final db = await instance.database;
    final id = await db.insert(arrivalGoodsTable, arrivalGoodsModel.toJson());

    return arrivalGoodsModel.copy(arrivalGoodsId: id);
  }

  Future<List<ArrivalGoodsModel>> fetchArrivalGoodsData() async {
    final db = await instance.database;
    const orderBy = '${ArrivalGoodsFields.arrivalGoodsDate} ASC';
    final fetchResult = await db.query(arrivalGoodsTable, orderBy: orderBy);

    return fetchResult.map((e) => ArrivalGoodsModel.fromJson(e)).toList();
  }

  Future<int> deleteArrivalGoods(ArrivalGoodsModel arrivalGoodsModel) async {
    final db = await instance.database;
    return db.delete(
      arrivalGoodsTable,
      where: '${ArrivalGoodsFields.arrivalGoodsId} = ?',
      whereArgs: [arrivalGoodsModel.arrivalGoodsId],
    );
  }
}
