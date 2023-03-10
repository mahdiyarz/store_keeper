import 'package:equatable/equatable.dart';

const String countedIncomingsTable = 'countedIncomings';

class CountedIncomingsFields {
  static const List<String> values = [
    id,
    incomingsId,
    warehouseId,
    goodId,
    withBoxes,
    withoutBox,
    price,
    totalCounted,
  ];

  static const String id = 'id';
  static const String incomingsId = 'incomingsId';
  static const String warehouseId = 'warehouseId';
  static const String goodId = 'goodId';
  static const String withBoxes = 'withBoxes';
  static const String withoutBox = 'withoutBox';
  static const String price = 'price';
  static const String totalCounted = 'totalCounted';
}

class CountedIncomingsModel extends Equatable {
  final int? id;
  final int incomingsId;
  final int warehouseId;
  final int goodId;
  final int? withBoxes;
  final int withoutBox;
  final int price;
  final int totalCounted;

  const CountedIncomingsModel({
    this.id,
    required this.incomingsId,
    required this.warehouseId,
    required this.goodId,
    required this.withoutBox,
    required this.withBoxes,
    required this.price,
    required this.totalCounted,
  });

  @override
  List<Object?> get props => [
        id,
        incomingsId,
        warehouseId,
        goodId,
        withoutBox,
        withBoxes,
        price,
        totalCounted,
      ];

  CountedIncomingsModel copy({
    int? id,
    int? incomingsId,
    int? warehouseId,
    int? goodId,
    int? withBoxes,
    int? withoutBox,
    int? price,
    int? totalCounted,
  }) {
    return CountedIncomingsModel(
      id: id ?? this.id,
      incomingsId: incomingsId ?? this.incomingsId,
      warehouseId: warehouseId ?? this.warehouseId,
      goodId: goodId ?? this.goodId,
      withBoxes: withBoxes ?? this.withBoxes,
      withoutBox: withoutBox ?? this.withoutBox,
      price: price ?? this.price,
      totalCounted: totalCounted ?? this.totalCounted,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'incomingsId': incomingsId,
      'warehouseId': warehouseId,
      'goodId': goodId,
      'withBoxes': withBoxes,
      'withoutBox': withoutBox,
      'price': price,
      'totalCounted': totalCounted,
    };
  }

  static CountedIncomingsModel fromJson(Map<String, dynamic> map) {
    return CountedIncomingsModel(
      id: map['id'] != null ? map['id'] as int : null,
      incomingsId: map['incomingsId'] as int,
      warehouseId: map['warehouseId'] as int,
      goodId: map['goodId'] as int,
      withBoxes: map['withBoxes'] != null ? map['withBoxes'] as int : null,
      withoutBox: map['withoutBox'] as int,
      price: map['price'] as int,
      totalCounted: map['totalCounted'] as int,
    );
  }
}
