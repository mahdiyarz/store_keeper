import 'package:equatable/equatable.dart';

const String countedOutputsTable = 'countedOutputs';

class CountedOutputsFields {
  static const String id = 'id';
  static const String outputId = 'outputId';
  static const String warehouseId = 'warehouseId';
  static const String goodId = 'goodId';
  static const String withBoxes = 'withBoxes';
  static const String withoutBox = 'withoutBox';
  static const String price = 'price';
  static const String totalCounted = 'totalCounted';

  static const List<String> values = [
    id,
    outputId,
    warehouseId,
    goodId,
    withBoxes,
    withoutBox,
    price,
    totalCounted,
  ];
}

class CountedOutputsModel extends Equatable {
  final int? id;
  final int outputId;
  final int warehouseId;
  final int goodId;
  final int? withBoxes;
  final int withoutBox;
  final int? price;
  final int totalCounted;
  const CountedOutputsModel({
    this.id,
    required this.outputId,
    required this.warehouseId,
    required this.goodId,
    this.withBoxes,
    required this.withoutBox,
    this.price,
    required this.totalCounted,
  });

  @override
  List<Object?> get props => [
        id,
        outputId,
        warehouseId,
        goodId,
        withBoxes,
        withoutBox,
        price,
        totalCounted,
      ];

  CountedOutputsModel copyWith({
    int? id,
    int? outputId,
    int? warehouseId,
    int? goodId,
    int? withBoxes,
    int? withoutBox,
    int? price,
    int? totalCounted,
  }) {
    return CountedOutputsModel(
      id: id ?? this.id,
      outputId: outputId ?? this.outputId,
      warehouseId: warehouseId ?? this.warehouseId,
      goodId: goodId ?? this.goodId,
      withBoxes: withBoxes ?? this.withBoxes,
      withoutBox: withoutBox ?? this.withoutBox,
      price: price ?? this.price,
      totalCounted: totalCounted ?? this.totalCounted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CountedOutputsFields.id: id,
      CountedOutputsFields.outputId: outputId,
      CountedOutputsFields.warehouseId: warehouseId,
      CountedOutputsFields.goodId: goodId,
      CountedOutputsFields.withBoxes: withBoxes,
      CountedOutputsFields.withoutBox: withoutBox,
      CountedOutputsFields.price: price,
      CountedOutputsFields.totalCounted: totalCounted,
    };
  }

  static CountedOutputsModel fromMap(Map<String, dynamic> map) {
    return CountedOutputsModel(
      id: map[CountedOutputsFields.id] != null
          ? map[CountedOutputsFields.id] as int
          : null,
      outputId: map[CountedOutputsFields.outputId] as int,
      warehouseId: map[CountedOutputsFields.warehouseId] as int,
      goodId: map[CountedOutputsFields.goodId] as int,
      withBoxes: map[CountedOutputsFields.withBoxes] != null
          ? map[CountedOutputsFields.withBoxes] as int
          : null,
      withoutBox: map[CountedOutputsFields.withoutBox] as int,
      price: map[CountedOutputsFields.price] != null
          ? map[CountedOutputsFields.price] as int
          : null,
      totalCounted: map[CountedOutputsFields.totalCounted] as int,
    );
  }
}
