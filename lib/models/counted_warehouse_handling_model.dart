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
      CountedWarehouseHandlingFields.id: id,
      CountedWarehouseHandlingFields.warehouseHandlingId: warehouseHandlingId,
      CountedWarehouseHandlingFields.goodId: goodId,
      CountedWarehouseHandlingFields.withBoxes: withBoxes,
      CountedWarehouseHandlingFields.withoutBox: withoutBox,
      CountedWarehouseHandlingFields.totalCounted: totalCounted,
    };
  }

  static CountedWarehouseHandlingModel fromMap(Map<String, dynamic> map) {
    return CountedWarehouseHandlingModel(
      id: map[CountedWarehouseHandlingFields.id] != null
          ? map[CountedWarehouseHandlingFields.id] as int
          : null,
      warehouseHandlingId:
          map[CountedWarehouseHandlingFields.warehouseHandlingId] as int,
      goodId: map[CountedWarehouseHandlingFields.goodId] as int,
      withBoxes: map[CountedWarehouseHandlingFields.withBoxes] != null
          ? map[CountedWarehouseHandlingFields.withBoxes] as int
          : null,
      withoutBox: map[CountedWarehouseHandlingFields.withoutBox] as int,
      totalCounted: map[CountedWarehouseHandlingFields.totalCounted] as int,
    );
  }
}
