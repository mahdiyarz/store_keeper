import 'package:equatable/equatable.dart';

const String stockTable = 'stock';

class StockFields {
  static const String id = 'id';
  static const String goodId = 'goodId';
  static const String totalStock = 'totalStock';

  static const List<String> values = [
    id,
    goodId,
    totalStock,
  ];
}

class StockModel extends Equatable {
  final int? id;
  final int goodId;
  final int totalStock;
  const StockModel({
    this.id,
    required this.goodId,
    required this.totalStock,
  });

  @override
  List<Object?> get props => [
        id,
        goodId,
        totalStock,
      ];

  StockModel copyWith({
    int? id,
    int? goodId,
    int? totalStock,
  }) {
    return StockModel(
      id: id ?? this.id,
      goodId: goodId ?? this.goodId,
      totalStock: totalStock ?? this.totalStock,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'goodId': goodId,
      'totalStock': totalStock,
    };
  }

  static StockModel fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'] != null ? map['id'] as int : null,
      goodId: map['goodId'] as int,
      totalStock: map['totalStock'] as int,
    );
  }
}
