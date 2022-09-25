final String arrivalGoodsTable = 'arrivalsGoods';

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
