final String goodsTable = 'goods';

class GoodsFields {
  static const String goodId = 'goodId';
  static const String goodName = 'goodName';
  static const String brandId = 'brandId';
  static const String numInBox = 'numInBox';
  static const String barcode = 'barcode';
}

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
