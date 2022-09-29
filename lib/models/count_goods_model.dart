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

  CountGoodsModel(
    this.countGoodsId,
    this.numOfBox,
    this.numOfSeed,
    this.price,
    this.goodsId,
    this.arrivalGoodsId,
    this.lakingId,
  );
}
