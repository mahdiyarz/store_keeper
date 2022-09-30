final String countGoodsTable = 'countGoods';

class CountGoodsFields {
  static const String countGoodsId = 'countGoodsId';
  static const String numOfBox = 'numOfBox';
  static const String numOfSeed = 'numOfSeed';
  static const String price = 'price';
  static const String goodsId = 'goodsId';
  static const String arrivalGoodsId = 'arrivalGoodsId';
  static const String lakingId = 'lakingId';
}

class CountGoodsModel {
  final int countGoodsId;
  final int numOfBox;
  final int numOfSeed;
  final BigInt price;
  final int goodsId;
  final int arrivalGoodsId;
  final int lakingId;

  CountGoodsModel({
    required this.countGoodsId,
    required this.numOfBox,
    required this.numOfSeed,
    required this.price,
    required this.goodsId,
    required this.arrivalGoodsId,
    required this.lakingId,
  });

  Map<String, Object> toJson() => {
        CountGoodsFields.countGoodsId: countGoodsId,
        CountGoodsFields.numOfBox: numOfBox,
        CountGoodsFields.numOfSeed: numOfSeed,
        CountGoodsFields.price: price,
        CountGoodsFields.goodsId: goodsId,
        CountGoodsFields.arrivalGoodsId: arrivalGoodsId,
        CountGoodsFields.lakingId: lakingId,
      };

  CountGoodsModel copy({
    int? countGoodsId,
    int? numOfBox,
    int? numOfSeed,
    BigInt? price,
    int? goodsId,
    int? arrivalGoodsId,
    int? lakingId,
  }) =>
      CountGoodsModel(
        countGoodsId: countGoodsId ?? this.countGoodsId,
        numOfBox: numOfBox ?? this.numOfBox,
        numOfSeed: numOfSeed ?? this.numOfSeed,
        price: price ?? this.price,
        goodsId: goodsId ?? this.goodsId,
        arrivalGoodsId: arrivalGoodsId ?? this.arrivalGoodsId,
        lakingId: lakingId ?? this.lakingId,
      );

  static CountGoodsModel fromJson(Map<String, Object?> json) => CountGoodsModel(
        countGoodsId: json[CountGoodsFields.countGoodsId] as int,
        numOfBox: json[CountGoodsFields.numOfBox] as int,
        numOfSeed: json[CountGoodsFields.numOfSeed] as int,
        price: json[CountGoodsFields.price] as BigInt,
        goodsId: json[CountGoodsFields.goodsId] as int,
        arrivalGoodsId: json[CountGoodsFields.arrivalGoodsId] as int,
        lakingId: json[CountGoodsFields.lakingId] as int,
      );
}
