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
        ${BrandsFields.brandLatinName}  $textType      
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

  Future closeDB() async {
    final db = await instance.database;

    db.close();
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

  Future<ArrivalGoodsModel> fetchSingleArrivalGoodData(
      int arrivalGoodsId) async {
    final db = await instance.database;

    final fetchResult = await db.query(
      arrivalGoodsTable,
      columns: ArrivalGoodsFields.values,
      where: '${ArrivalGoodsFields.arrivalGoodsId} = ?',
      whereArgs: [arrivalGoodsId],
    );

    if (fetchResult.isNotEmpty) {
      return ArrivalGoodsModel.fromJson(fetchResult.first);
    } else {
      throw Exception('ID $arrivalGoodsId not found');
    }
  }

  Future<int> updateArrivalGoods(ArrivalGoodsModel arrivalGoodsModel) async {
    final db = await instance.database;

    return db.update(
      arrivalGoodsTable,
      arrivalGoodsModel.toJson(),
      where: '${ArrivalGoodsFields.arrivalGoodsId} = ?',
      whereArgs: [arrivalGoodsModel.arrivalGoodsId],
    );
  }

  Future<int> deleteArrivalGoods(ArrivalGoodsModel arrivalGoodsModel) async {
    final db = await instance.database;
    return db.delete(
      arrivalGoodsTable,
      where: '${ArrivalGoodsFields.arrivalGoodsId} = ?',
      whereArgs: [arrivalGoodsModel.arrivalGoodsId],
    );
  }

  //* Brands Logics

  Future<BrandsModel> insertBrands(BrandsModel brandsModel) async {
    final db = await instance.database;
    final id = await db.insert(brandsTable, brandsModel.toJson());

    return brandsModel.copy(brandId: id);
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
