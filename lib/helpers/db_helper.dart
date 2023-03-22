import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart' as pathPackage;

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
        ${StockFields.countedIncomingId} $intType,
        ${StockFields.countedOutputId} $intType,
        ${StockFields.date} $textType,
        ${StockFields.totalStock}  $intType      
      )
     ''');

    await db.execute('''
      CREATE TABLE $stockEachWarehouseTable(
        ${StockEachWarehouseFields.id} $idType,
        ${StockEachWarehouseFields.goodId} $intType,
        ${StockEachWarehouseFields.warehouseId}  $intType,      
        ${StockEachWarehouseFields.countedIncomingId}  $intType,      
        ${StockEachWarehouseFields.countedOutputId}  $intType,      
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
        ${WarehousesFields.warehouseId} $idType,
        ${WarehousesFields.warehouseName} $textType
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

  //* Incoming List Logics

  Future<IncomingsModel> insertIncomingList(
      IncomingsModel incomingListModel) async {
    final db = await instance.database;
    final id = await db.insert(incomingsTable, incomingListModel.toJson());

    return incomingListModel.copy(incomingId: id);
  }

  Future<List<IncomingsModel>> fetchIncomingListData() async {
    final db = await instance.database;
    const orderBy = '${IncomingsFields.incomingDate} ASC';
    final fetchResult = await db.query(incomingsTable, orderBy: orderBy);

    return fetchResult.map((e) => IncomingsModel.fromJson(e)).toList();
  }

  Future<IncomingsModel> fetchSingleIncomingGoodData(int incomingId) async {
    final db = await instance.database;

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

  Future<int> updateIncomingList(IncomingsModel incomingListModel) async {
    final db = await instance.database;

    return db.update(
      incomingsTable,
      incomingListModel.toJson(),
      where: '${IncomingsFields.incomingId} = ?',
      whereArgs: [incomingListModel.incomingId],
    );
  }

  Future<int> deleteIncomingList(IncomingsModel incomingListModel) async {
    final db = await instance.database;
    return db.delete(
      incomingsTable,
      where: '${IncomingsFields.incomingId} = ?',
      whereArgs: [incomingListModel.incomingId],
    );
  }

  //* Counted Incomings Logics

  Future<CountedIncomingsModel> insertCountedIncoming(
      CountedIncomingsModel countedIncomingsModel) async {
    final db = await instance.database;
    final id =
        await db.insert(countedIncomingsTable, countedIncomingsModel.toJson());

    return countedIncomingsModel.copy(id: id);
  }

  Future<List<CountedIncomingsModel>> fetchCountedIncomingsData() async {
    final db = await instance.database;
    const orderBy = '${CountedIncomingsFields.totalCounted} ASC';
    final fetchResult = await db.query(countedIncomingsTable, orderBy: orderBy);

    return fetchResult.map((e) => CountedIncomingsModel.fromJson(e)).toList();
  }

  // Future<CountedIncomingsModel> fetchSingleIncomingGoodData(int incomingId) async {
  //   final db = await instance.database;

  //   final fetchResult = await db.query(
  //     countedIncomingsTable,
  //     columns: CountedIncomingsFields.values,
  //     where: '${CountedIncomingsFields.incomingId} = ?',
  //     whereArgs: [incomingId],
  //   );

  //   if (fetchResult.isNotEmpty) {
  //     return CountedIncomingsModel.fromJson(fetchResult.first);
  //   } else {
  //     throw Exception('ID $incomingId not found');
  //   }
  // }

  Future<int> updateCountedIncoming(
      CountedIncomingsModel countedIncomingsModel) async {
    final db = await instance.database;

    return db.update(
      countedIncomingsTable,
      countedIncomingsModel.toJson(),
      where: '${CountedIncomingsFields.id} = ?',
      whereArgs: [countedIncomingsModel.id],
    );
  }

  Future<int> deleteCountedIncoming(
      CountedIncomingsModel countedIncomingsModel) async {
    final db = await instance.database;
    return db.delete(
      countedIncomingsTable,
      where: '${CountedIncomingsFields.id} = ?',
      whereArgs: [countedIncomingsModel.id],
    );
  }

  //* Stock CRUD queries

  Future<StockModel> insertStock(StockModel stockModel) async {
    final db = await instance.database;
    final id = await db.insert(stockTable, stockModel.toMap());

    return stockModel.copyWith(id: id);
  }

  Future<List<StockModel>> fetchStocksData() async {
    final db = await instance.database;
    const orderBy = '${StockFields.id} ASC';
    final fetchResult = await db.query(stockTable, orderBy: orderBy);

    return fetchResult.map((e) => StockModel.fromMap(e)).toList();
  }

  Future<int> updateStock(StockModel stockModel) async {
    final db = await instance.database;

    return db.update(
      stockTable,
      stockModel.toMap(),
      where: '${StockFields.id} = ?',
      whereArgs: [stockModel.id],
    );
  }

  Future<int> deleteStock(StockModel stockModel) async {
    final db = await instance.database;
    return db.delete(
      stockTable,
      where: '${StockFields.id} = ?',
      whereArgs: [stockModel.id],
    );
  }

  //* Stock each warehouse CRUD queries

  Future<StockEachWarehouseModel> insertStockEachWarehouse(
      StockEachWarehouseModel stockEachWarehouseModel) async {
    final db = await instance.database;
    final id = await db.insert(
        stockEachWarehouseTable, stockEachWarehouseModel.toMap());

    return stockEachWarehouseModel.copyWith(id: id);
  }

  Future<List<StockEachWarehouseModel>> fetchStocksEachWarehouseData() async {
    final db = await instance.database;
    const orderBy = '${StockEachWarehouseFields.id} ASC';
    final fetchResult =
        await db.query(stockEachWarehouseTable, orderBy: orderBy);

    return fetchResult.map((e) => StockEachWarehouseModel.fromMap(e)).toList();
  }

  Future<int> updateStockEachWarehouse(
      StockEachWarehouseModel stockEachWarehouseModel) async {
    final db = await instance.database;

    return db.update(
      stockEachWarehouseTable,
      stockEachWarehouseModel.toMap(),
      where: '${StockEachWarehouseFields.id} = ?',
      whereArgs: [stockEachWarehouseModel.id],
    );
  }

  Future<int> deleteStockEachWarehouse(
      StockEachWarehouseModel stockEachWarehouseModel) async {
    final db = await instance.database;
    return db.delete(
      stockEachWarehouseTable,
      where: '${StockEachWarehouseFields.id} = ?',
      whereArgs: [stockEachWarehouseModel.id],
    );
  }

  //* warehouse handling CRUD queries

  Future<WarehouseHandlingModel> insertWarehouseHandling(
      WarehouseHandlingModel warehouseHandlingModel) async {
    final db = await instance.database;
    final id = await db.insert(warehousesTable, warehouseHandlingModel.toMap());

    return warehouseHandlingModel.copyWith(id: id);
  }

  Future<List<WarehouseHandlingModel>> fetchWarehouseHandlingsData() async {
    final db = await instance.database;
    const orderBy = '${WarehouseHandlingFields.date} ASC';
    final fetchResult = await db.query(warehousesTable, orderBy: orderBy);

    return fetchResult.map((e) => WarehouseHandlingModel.fromMap(e)).toList();
  }

  Future<int> updateWarehouseHandling(
      WarehouseHandlingModel warehouseHandlingModel) async {
    final db = await instance.database;

    return db.update(
      warehousesTable,
      warehouseHandlingModel.toMap(),
      where: '${WarehouseHandlingFields.id} = ?',
      whereArgs: [warehouseHandlingModel.id],
    );
  }

  Future<int> deleteWarehouseHandling(
      WarehouseHandlingModel warehouseHandlingModel) async {
    final db = await instance.database;
    return db.delete(
      warehousesTable,
      where: '${WarehouseHandlingFields.id} = ?',
      whereArgs: [warehouseHandlingModel.id],
    );
  }

  //* Counted warehouse handling CRUD queries

  Future<CountedWarehouseHandlingModel> insertCountedWarehouseHandling(
      CountedWarehouseHandlingModel countedWarehouseHandlingModel) async {
    final db = await instance.database;
    final id = await db.insert(
        countedWarehouseHandlingTable, countedWarehouseHandlingModel.toMap());

    return countedWarehouseHandlingModel.copyWith(id: id);
  }

  Future<List<CountedWarehouseHandlingModel>>
      fetchCountedWarehouseHandlingsData() async {
    final db = await instance.database;
    const orderBy = '${CountedWarehouseHandlingFields.totalCounted} ASC';
    final fetchResult =
        await db.query(countedWarehouseHandlingTable, orderBy: orderBy);

    return fetchResult
        .map((e) => CountedWarehouseHandlingModel.fromMap(e))
        .toList();
  }

  Future<int> updateCountedWarehouseHandling(
      CountedWarehouseHandlingModel countedWarehouseHandlingModel) async {
    final db = await instance.database;

    return db.update(
      countedWarehouseHandlingTable,
      countedWarehouseHandlingModel.toMap(),
      where: '${CountedWarehouseHandlingFields.id} = ?',
      whereArgs: [countedWarehouseHandlingModel.id],
    );
  }

  Future<int> deleteCountedWarehouseHandling(
      CountedWarehouseHandlingModel countedWarehouseHandlingModel) async {
    final db = await instance.database;
    return db.delete(
      countedWarehouseHandlingTable,
      where: '${CountedWarehouseHandlingFields.id} = ?',
      whereArgs: [countedWarehouseHandlingModel.id],
    );
  }

  //* Outputs CRUD queries

  Future<OutputsModel> insertOutput(OutputsModel outputsModel) async {
    final db = await instance.database;
    final id = await db.insert(outputsTable, outputsModel.toMap());

    return outputsModel.copyWith(id: id);
  }

  Future<List<OutputsModel>> fetchOutputsData() async {
    final db = await instance.database;
    const orderBy = '${OutputsFields.date} ASC';
    final fetchResult = await db.query(outputsTable, orderBy: orderBy);

    return fetchResult.map((e) => OutputsModel.fromMap(e)).toList();
  }

  Future<int> updateOutput(OutputsModel outputsModel) async {
    final db = await instance.database;

    return db.update(
      outputsTable,
      outputsModel.toMap(),
      where: '${OutputsFields.id} = ?',
      whereArgs: [outputsModel.id],
    );
  }

  Future<int> deleteOutput(OutputsModel outputsModel) async {
    final db = await instance.database;
    return db.delete(
      outputsTable,
      where: '${OutputsFields.id} = ?',
      whereArgs: [outputsModel.id],
    );
  }

  //* Counted Outputs CRUD queries

  Future<CountedOutputsModel> insertCountedOutput(
      CountedOutputsModel countedOutputsModel) async {
    final db = await instance.database;
    final id =
        await db.insert(countedOutputsTable, countedOutputsModel.toMap());

    return countedOutputsModel.copyWith(id: id);
  }

  Future<List<CountedOutputsModel>> fetchCountedOutputsData() async {
    final db = await instance.database;
    const orderBy = '${CountedOutputsFields.totalCounted} ASC';
    final fetchResult = await db.query(countedOutputsTable, orderBy: orderBy);

    return fetchResult.map((e) => CountedOutputsModel.fromMap(e)).toList();
  }

  Future<int> updateCountedOutput(
      CountedOutputsModel countedOutputsModel) async {
    final db = await instance.database;

    return db.update(
      countedOutputsTable,
      countedOutputsModel.toMap(),
      where: '${CountedOutputsFields.id} = ?',
      whereArgs: [countedOutputsModel.id],
    );
  }

  Future<int> deleteCountedOutput(
      CountedOutputsModel countedOutputsModel) async {
    final db = await instance.database;
    return db.delete(
      countedOutputsTable,
      where: '${CountedOutputsFields.id} = ?',
      whereArgs: [countedOutputsModel.id],
    );
  }

  //* Counted Transfers CRUD queries

  Future<CountedTransfersModel> insertCountedTransfer(
      CountedTransfersModel countedTransfersModel) async {
    final db = await instance.database;
    final id =
        await db.insert(countedTransfersTable, countedTransfersModel.toMap());

    return countedTransfersModel.copyWith(id: id);
  }

  Future<List<CountedTransfersModel>> fetchCountedTransfersData() async {
    final db = await instance.database;
    const orderBy = '${CountedTransfersFields.totalCounted} ASC';
    final fetchResult = await db.query(countedTransfersTable, orderBy: orderBy);

    return fetchResult.map((e) => CountedTransfersModel.fromMap(e)).toList();
  }

  Future<int> updateCountedTransfer(
      CountedTransfersModel countedTransfersModel) async {
    final db = await instance.database;

    return db.update(
      countedTransfersTable,
      countedTransfersModel.toMap(),
      where: '${CountedTransfersFields.id} = ?',
      whereArgs: [countedTransfersModel.id],
    );
  }

  Future<int> deleteCountedTransfer(
      CountedTransfersModel countedTransfersModel) async {
    final db = await instance.database;
    return db.delete(
      countedTransfersTable,
      where: '${CountedTransfersFields.id} = ?',
      whereArgs: [countedTransfersModel.id],
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

  //* Transfers CRUD scrips

  Future<TransfersModel> insertTransfer(TransfersModel transfersModel) async {
    final db = await instance.database;
    final result = await db.insert(transfersTable, transfersModel.toJson());

    return transfersModel.copyWith(id: result);
  }

  Future<List<TransfersModel>> fetchTransfersData() async {
    final db = await instance.database;
    const orderBy = '${TransfersField.date} ASC';
    final fetchResult = await db.query(transfersTable, orderBy: orderBy);

    return fetchResult.map((e) => TransfersModel.fromJson(e)).toList();
  }

  Future<int> updateTransfer(TransfersModel transfersModel) async {
    final db = await instance.database;

    return db.update(
      transfersTable,
      transfersModel.toJson(),
      where: '${TransfersField.id} = ?',
      whereArgs: [transfersModel.id],
    );
  }

  Future<int> deleteTransfer(TransfersModel transfersModel) async {
    final db = await instance.database;
    return db.delete(
      transfersTable,
      where: '${TransfersField.id} = ?',
      whereArgs: [transfersModel.id],
    );
  }

  //* Warehouse CRUD scrips

  Future<WarehousesModel> insertWarehouse(
      WarehousesModel warehousesModel) async {
    final db = await instance.database;
    final result = await db.insert(warehousesTable, warehousesModel.toMap());

    return warehousesModel.copyWith(warehouseId: result);
  }

  Future<List<WarehousesModel>> fetchWarehousesData() async {
    final db = await instance.database;
    const orderBy = '${WarehousesFields.warehouseName} ASC';
    final fetchResult = await db.query(warehousesTable, orderBy: orderBy);

    return fetchResult.map((e) => WarehousesModel.fromMap(e)).toList();
  }

  Future<int> updateWarehouse(WarehousesModel warehousesModel) async {
    final db = await instance.database;

    return db.update(
      warehousesTable,
      warehousesModel.toMap(),
      where: '${WarehousesFields.warehouseId} = ?',
      whereArgs: [warehousesModel.warehouseId],
    );
  }

  Future<int> deleteWarehouse(WarehousesModel warehousesModel) async {
    final db = await instance.database;
    return db.delete(
      warehousesTable,
      where: '${WarehousesFields.warehouseId} = ?',
      whereArgs: [warehousesModel.warehouseId],
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
