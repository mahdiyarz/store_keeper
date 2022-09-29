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
}
