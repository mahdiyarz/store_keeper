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
      'id': id,
      'outputId': outputId,
      'warehouseId': warehouseId,
      'goodId': goodId,
      'withBoxes': withBoxes,
      'withoutBox': withoutBox,
      'price': price,
      'totalCounted': totalCounted,
    };
  }

  static CountedOutputsModel fromMap(Map<String, dynamic> map) {
    return CountedOutputsModel(
      id: map['id'] != null ? map['id'] as int : null,
      outputId: map['outputId'] as int,
      warehouseId: map['warehouseId'] as int,
      goodId: map['goodId'] as int,
      withBoxes: map['withBoxes'] != null ? map['withBoxes'] as int : null,
      withoutBox: map['withoutBox'] as int,
      price: map['price'] != null ? map['price'] as int : null,
      totalCounted: map['totalCounted'] as int,
    );
  }
}
