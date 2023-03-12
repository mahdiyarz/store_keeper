import 'package:equatable/equatable.dart';

const String stockEachWarehouseTable = 'stockEachWarehouse';

class StockEachWarehouseFields {
  static const String id = 'id';
  static const String goodId = 'goodId';
  static const String warehouseId = 'warehouseId';
  static const String totalStock = 'totalStock';

  static const List<String> values = [
    id,
    goodId,
    warehouseId,
    totalStock,
  ];
}

class StockEachWarehouseModel extends Equatable {
  final int? id;
  final int goodId;
  final int warehouseId;
  final int totalStock;
  const StockEachWarehouseModel({
    this.id,
    required this.goodId,
    required this.warehouseId,
    required this.totalStock,
  });

  @override
  List<Object?> get props => [
        id,
        goodId,
        warehouseId,
        totalStock,
      ];

  StockEachWarehouseModel copyWith({
    int? id,
    int? goodId,
    int? warehouseId,
    int? totalStock,
  }) {
    return StockEachWarehouseModel(
      id: id ?? this.id,
      goodId: goodId ?? this.goodId,
      warehouseId: warehouseId ?? this.warehouseId,
      totalStock: totalStock ?? this.totalStock,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'goodId': goodId,
      'warehouseId': warehouseId,
      'totalStock': totalStock,
    };
  }

  static StockEachWarehouseModel fromMap(Map<String, dynamic> map) {
    return StockEachWarehouseModel(
      id: map['id'] != null ? map['id'] as int : null,
      goodId: map['goodId'] as int,
      warehouseId: map['warehouseId'] as int,
      totalStock: map['totalStock'] as int,
    );
  }
}
