import 'package:equatable/equatable.dart';

const String stockEachWarehouseTable = 'stockEachWarehouse';

class StockEachWarehouseFields {
  static const String id = 'id';
  static const String goodId = 'goodId';
  static const String warehouseId = 'warehouseId';
  static const String totalStock = 'totalStock';
  static const String date = 'date';

  static const List<String> values = [
    id,
    goodId,
    warehouseId,
    totalStock,
    date,
  ];
}

class StockEachWarehouseModel extends Equatable {
  final int? id;
  final int goodId;
  final int warehouseId;
  final int totalStock;
  final DateTime date;
  const StockEachWarehouseModel({
    this.id,
    required this.goodId,
    required this.warehouseId,
    required this.totalStock,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        goodId,
        warehouseId,
        totalStock,
        date,
      ];

  StockEachWarehouseModel copyWith({
    int? id,
    int? goodId,
    int? warehouseId,
    int? totalStock,
    DateTime? date,
  }) {
    return StockEachWarehouseModel(
      id: id ?? this.id,
      goodId: goodId ?? this.goodId,
      warehouseId: warehouseId ?? this.warehouseId,
      totalStock: totalStock ?? this.totalStock,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'goodId': goodId,
      'warehouseId': warehouseId,
      'totalStock': totalStock,
      'date': date.toIso8601String(),
    };
  }

  static StockEachWarehouseModel fromMap(Map<String, dynamic> map) {
    return StockEachWarehouseModel(
      id: map['id'] != null ? map['id'] as int : null,
      goodId: map['goodId'] as int,
      warehouseId: map['warehouseId'] as int,
      totalStock: map['totalStock'] as int,
      date: DateTime.parse(map['date'] as String),
    );
  }
}
