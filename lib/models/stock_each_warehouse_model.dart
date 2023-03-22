import 'package:equatable/equatable.dart';

const String stockEachWarehouseTable = 'stockEachWarehouse';

class StockEachWarehouseFields {
  static const String id = 'id';
  static const String goodId = 'goodId';
  static const String warehouseId = 'warehouseId';
  static const String totalStock = 'totalStock';
  static const String date = 'date';
  static const String countedIncomingId = 'countedIncomingId';
  static const String countedOutputId = 'countedOutputId';

  static const List<String> values = [
    id,
    goodId,
    warehouseId,
    totalStock,
    date,
    countedIncomingId,
    countedOutputId,
  ];
}

class StockEachWarehouseModel extends Equatable {
  final int? id;
  final int goodId;
  final int warehouseId;
  final int totalStock;
  final DateTime date;
  final int? countedIncomingId;
  final int? countedOutputId;
  const StockEachWarehouseModel({
    this.id,
    required this.goodId,
    required this.warehouseId,
    required this.totalStock,
    required this.date,
    this.countedIncomingId,
    this.countedOutputId,
  });

  @override
  List<Object?> get props => [
        id,
        goodId,
        warehouseId,
        totalStock,
        date,
        countedIncomingId,
        countedOutputId,
      ];

  StockEachWarehouseModel copyWith({
    int? id,
    int? goodId,
    int? warehouseId,
    int? totalStock,
    DateTime? date,
    int? countedIncomingId,
    int? countedOutputId,
  }) {
    return StockEachWarehouseModel(
      id: id ?? this.id,
      goodId: goodId ?? this.goodId,
      warehouseId: warehouseId ?? this.warehouseId,
      totalStock: totalStock ?? this.totalStock,
      date: date ?? this.date,
      countedIncomingId: countedIncomingId ?? this.countedIncomingId,
      countedOutputId: countedOutputId ?? this.countedOutputId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'goodId': goodId,
      'warehouseId': warehouseId,
      'totalStock': totalStock,
      'date': date.toIso8601String(),
      StockEachWarehouseFields.countedIncomingId: countedIncomingId,
      StockEachWarehouseFields.countedOutputId: countedOutputId,
    };
  }

  static StockEachWarehouseModel fromMap(Map<String, dynamic> map) {
    return StockEachWarehouseModel(
      id: map['id'] != null ? map['id'] as int : null,
      goodId: map['goodId'] as int,
      warehouseId: map['warehouseId'] as int,
      totalStock: map['totalStock'] as int,
      date: DateTime.parse(map['date'] as String),
      countedIncomingId: map[StockEachWarehouseFields.countedIncomingId] != null
          ? map[StockEachWarehouseFields.countedIncomingId] as int
          : null,
      countedOutputId: map[StockEachWarehouseFields.countedOutputId] != null
          ? map[StockEachWarehouseFields.countedOutputId] as int
          : null,
    );
  }
}
