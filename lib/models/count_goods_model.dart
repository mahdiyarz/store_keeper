import 'package:equatable/equatable.dart';

const String countGoodsTable = 'countGoods';

class CountGoodsFields {
  static const List<String> values = [
    countGoodsId,
    numOfBox,
    numOfSeed,
    price,
    goodsId,
    incomingListId,
    lakingId,
  ];

  static const String countGoodsId = 'countGoodsId';
  static const String numOfBox = 'numOfBox';
  static const String numOfSeed = 'numOfSeed';
  static const String price = 'price';
  static const String goodsId = 'goodsId';
  static const String incomingListId = 'incomingListId';
  static const String lakingId = 'lakingId';
}

class CountGoodsModel extends Equatable {
  final int countGoodsId;
  final int? numOfBox;
  final int? numOfSeed;
  final int? price;
  final int goodsId;
  final int? incomingListId;
  final int? lakingId;

  const CountGoodsModel({
    required this.countGoodsId,
    required this.numOfBox,
    required this.numOfSeed,
    required this.price,
    required this.goodsId,
    required this.incomingListId,
    required this.lakingId,
  });

  Map<String, Object?> toJson() => {
        CountGoodsFields.countGoodsId: countGoodsId,
        CountGoodsFields.numOfBox: numOfBox,
        CountGoodsFields.numOfSeed: numOfSeed,
        CountGoodsFields.price: price,
        CountGoodsFields.goodsId: goodsId,
        CountGoodsFields.incomingListId: incomingListId,
        CountGoodsFields.lakingId: lakingId,
      };

  CountGoodsModel copy({
    int? countGoodsId,
    int? numOfBox,
    int? numOfSeed,
    int? price,
    int? goodsId,
    int? incomingListId,
    int? lakingId,
  }) =>
      CountGoodsModel(
        countGoodsId: countGoodsId ?? this.countGoodsId,
        numOfBox: numOfBox ?? this.numOfBox,
        numOfSeed: numOfSeed ?? this.numOfSeed,
        price: price ?? this.price,
        goodsId: goodsId ?? this.goodsId,
        incomingListId: incomingListId ?? this.incomingListId,
        lakingId: lakingId ?? this.lakingId,
      );

  static CountGoodsModel fromJson(Map<String, Object?> json) => CountGoodsModel(
        countGoodsId: json[CountGoodsFields.countGoodsId] as int,
        numOfBox: json[CountGoodsFields.numOfBox] as int,
        numOfSeed: json[CountGoodsFields.numOfSeed] as int,
        price: json[CountGoodsFields.price] as int,
        goodsId: json[CountGoodsFields.goodsId] as int,
        incomingListId: json[CountGoodsFields.incomingListId] as int,
        lakingId: json[CountGoodsFields.lakingId] as int,
      );

  @override
  List<Object?> get props => [
        countGoodsId,
        numOfBox,
        numOfSeed,
        price,
        goodsId,
        incomingListId,
        lakingId,
      ];
}
