final String goodsTable = 'goods';

class GoodsModel {
  final int goodId;
  final String goodName;
  final int brandId;
  final int numInBox;
  final BigInt barcode;

  GoodsModel(
    this.goodId,
    this.goodName,
    this.brandId,
    this.numInBox,
    this.barcode,
  );
}
