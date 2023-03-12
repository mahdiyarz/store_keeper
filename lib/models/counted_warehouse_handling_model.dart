import 'package:equatable/equatable.dart';

const String countedWarehouseHandlingTable = 'countedWarehouseHandling';

class CountedWarehouseHandlingFields {
  static const String id = 'id';
  static const String warehouseHandlingId = 'warehouseHandlingId';
  static const String goodId = 'goodId';
  static const String withBoxes = 'withBoxes';
  static const String withoutBox = 'withoutBox';
  static const String totalCounted = 'totalCounted';

  static const List<String> values = [
    id,
    warehouseHandlingId,
    goodId,
    withBoxes,
    withoutBox,
    totalCounted,
  ];
}

class CountedWarehouseHandlingModel extends Equatable {
  final int? id;
  final int warehouseHandlingId;
  final int goodId;
  final int? withBoxes;
  final int withoutBox;
  final int totalCounted;
  const CountedWarehouseHandlingModel({
    this.id,
    required this.warehouseHandlingId,
    required this.goodId,
    this.withBoxes,
    required this.withoutBox,
    required this.totalCounted,
  });

  @override
  List<Object?> get props => [
        id,
        warehouseHandlingId,
        goodId,
        withBoxes,
        withoutBox,
        totalCounted,
      ];

  CountedWarehouseHandlingModel copyWith({
    int? id,
    int? warehouseHandlingId,
    int? goodId,
    int? withBoxes,
    int? withoutBox,
    int? totalCounted,
  }) {
    return CountedWarehouseHandlingModel(
      id: id ?? this.id,
      warehouseHandlingId: warehouseHandlingId ?? this.warehouseHandlingId,
      goodId: goodId ?? this.goodId,
      withBoxes: withBoxes ?? this.withBoxes,
      withoutBox: withoutBox ?? this.withoutBox,
      totalCounted: totalCounted ?? this.totalCounted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'warehouseHandlingId': warehouseHandlingId,
      'goodId': goodId,
      'withBoxes': withBoxes,
      'withoutBox': withoutBox,
      'totalCounted': totalCounted,
    };
  }

  static CountedWarehouseHandlingModel fromMap(Map<String, dynamic> map) {
    return CountedWarehouseHandlingModel(
      id: map['id'] != null ? map['id'] as int : null,
      warehouseHandlingId: map['warehouseHandlingId'] as int,
      goodId: map['goodId'] as int,
      withBoxes: map['withBoxes'] != null ? map['withBoxes'] as int : null,
      withoutBox: map['withoutBox'] as int,
      totalCounted: map['totalCounted'] as int,
    );
  }
}
