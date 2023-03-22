import 'package:equatable/equatable.dart';

const String stockTable = 'stock';

class StockFields {
  static const String id = 'id';
  static const String goodId = 'goodId';
  static const String totalStock = 'totalStock';
  static const String date = 'date';
  static const String countedIncomingId = 'countedIncomingId';
  static const String countedOutputId = 'countedOutputId';

  static const List<String> values = [
    id,
    goodId,
    totalStock,
    date,
    countedIncomingId,
    countedOutputId,
  ];
}

class StockModel extends Equatable {
  final int? id;
  final int goodId;
  final int totalStock;
  final DateTime date;
  final int? countedIncomingId;
  final int? countedOutputId;
  const StockModel({
    this.id,
    required this.goodId,
    required this.totalStock,
    required this.date,
    this.countedIncomingId,
    this.countedOutputId,
  });

  @override
  List<Object?> get props => [
        id,
        goodId,
        totalStock,
        date,
        countedIncomingId,
        countedOutputId,
      ];

  StockModel copyWith({
    int? id,
    int? goodId,
    int? totalStock,
    DateTime? date,
    int? countedIncomingId,
    int? countedOutputId,
  }) {
    return StockModel(
      id: id ?? this.id,
      goodId: goodId ?? this.goodId,
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
      'totalStock': totalStock,
      'date': date.toIso8601String(),
      StockFields.countedIncomingId: countedIncomingId,
      StockFields.countedOutputId: countedOutputId,
    };
  }

  static StockModel fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'] != null ? map['id'] as int : null,
      goodId: map['goodId'] as int,
      totalStock: map['totalStock'] as int,
      date: DateTime.parse(map['date'] as String),
      countedIncomingId: map[StockFields.countedIncomingId] != null
          ? map[StockFields.countedIncomingId] as int
          : null,
      countedOutputId: map[StockFields.countedOutputId] != null
          ? map[StockFields.countedOutputId] as int
          : null,
    );
  }
}
