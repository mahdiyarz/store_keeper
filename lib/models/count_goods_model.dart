final String countGoodsTable = 'countGoods';

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
