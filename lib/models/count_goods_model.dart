import 'package:equatable/equatable.dart';

const String countGoodsTable = 'countGoods';

class CountGoodsFields {
  static const List<String> values = [
    id,
    numOfBox,
    numOfSeed,
    price,
    goodsId,
    incomingListId,
    lakingId,
  ];

  static const String id = 'id';
  static const String numOfBox = 'numOfBox';
  static const String numOfSeed = 'numOfSeed';
  static const String price = 'price';
  static const String goodsId = 'goodsId';
  static const String incomingListId = 'incomingListId';
  static const String lakingId = 'lakingId';
}

class CountGoodsModel extends Equatable {
  final int? id;
  final int? numOfBox;
  final int? numOfSeed;
  final int? price;
  final int goodsId;
  final int? incomingListId;
  final int? lakingId;

  const CountGoodsModel({
    this.id,
    required this.numOfBox,
    required this.numOfSeed,
    required this.price,
    required this.goodsId,
    required this.incomingListId,
    required this.lakingId,
  });

  Map<String, Object?> toMap() => {
        CountGoodsFields.id: id,
        CountGoodsFields.numOfBox: numOfBox,
        CountGoodsFields.numOfSeed: numOfSeed,
        CountGoodsFields.price: price,
        CountGoodsFields.goodsId: goodsId,
        CountGoodsFields.incomingListId: incomingListId,
        CountGoodsFields.lakingId: lakingId,
      };

  CountGoodsModel copyWith({
    int? id,
    int? numOfBox,
    int? numOfSeed,
    int? price,
    int? goodsId,
    int? incomingListId,
    int? lakingId,
  }) =>
      CountGoodsModel(
        id: id ?? this.id,
        numOfBox: numOfBox ?? this.numOfBox,
        numOfSeed: numOfSeed ?? this.numOfSeed,
        price: price ?? this.price,
        goodsId: goodsId ?? this.goodsId,
        incomingListId: incomingListId ?? this.incomingListId,
        lakingId: lakingId ?? this.lakingId,
      );

  static CountGoodsModel fromMap(Map<String, Object?> json) => CountGoodsModel(
        id: json[CountGoodsFields.id] as int?,
        numOfBox: json[CountGoodsFields.numOfBox] as int?,
        numOfSeed: json[CountGoodsFields.numOfSeed] as int?,
        price: json[CountGoodsFields.price] as int?,
        goodsId: json[CountGoodsFields.goodsId] as int,
        incomingListId: json[CountGoodsFields.incomingListId] as int?,
        lakingId: json[CountGoodsFields.lakingId] as int?,
      );

  @override
  List<Object?> get props => [
        id,
        numOfBox,
        numOfSeed,
        price,
        goodsId,
        incomingListId,
        lakingId,
      ];
}
