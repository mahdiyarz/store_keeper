final String arrivalGoodsTable = 'arrivalsGoods';

class ArrivalGoodsFields {
  static const String arrivalGoodsId = 'arrivalGoodsId';
  static const String brandId = 'brandId';
  static const String numOfBoxes = 'numOfBoxes';
  static const String arrivalGoodsDate = 'arrivalGoodsDate';
}

class ArrivalGoodsModel {
  final int arrivalGoodsId;
  final int brandId;
  final int numOfBoxes;
  final DateTime arrivalGoodsDate;

  ArrivalGoodsModel(
    this.arrivalGoodsId,
    this.brandId,
    this.numOfBoxes,
    this.arrivalGoodsDate,
  );
}
