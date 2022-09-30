const String arrivalGoodsTable = 'arrivalsGoods';

class ArrivalGoodsFields {
  static const String arrivalGoodsId = 'arrivalGoodsId';
  static const String brandId = 'brandId';
  static const String numOfBoxes = 'numOfBoxes';
  static const String arrivalGoodsDate = 'arrivalGoodsDate';
}

class ArrivalGoodsModel {
  final int? arrivalGoodsId;
  final int brandId;
  final int numOfBoxes;
  final DateTime arrivalGoodsDate;

  ArrivalGoodsModel({
    this.arrivalGoodsId,
    required this.brandId,
    required this.numOfBoxes,
    required this.arrivalGoodsDate,
  });

  Map<String, Object?> toJson() => {
        ArrivalGoodsFields.arrivalGoodsId: arrivalGoodsId,
        ArrivalGoodsFields.brandId: brandId,
        ArrivalGoodsFields.numOfBoxes: numOfBoxes,
        ArrivalGoodsFields.arrivalGoodsDate: arrivalGoodsDate.toIso8601String(),
      };

  ArrivalGoodsModel copy({
    int? arrivalGoodsId,
    int? brandId,
    int? numOfBoxes,
    DateTime? arrivalGoodsDate,
  }) =>
      ArrivalGoodsModel(
        arrivalGoodsId: arrivalGoodsId ?? this.arrivalGoodsId,
        brandId: brandId ?? this.brandId,
        numOfBoxes: numOfBoxes ?? this.numOfBoxes,
        arrivalGoodsDate: arrivalGoodsDate ?? this.arrivalGoodsDate,
      );

  static ArrivalGoodsModel fromJson(Map<String, Object?> json) =>
      ArrivalGoodsModel(
        arrivalGoodsId: json[ArrivalGoodsFields.arrivalGoodsId] as int,
        brandId: json[ArrivalGoodsFields.brandId] as int,
        numOfBoxes: json[ArrivalGoodsFields.numOfBoxes] as int,
        arrivalGoodsDate:
            DateTime.parse(json[ArrivalGoodsFields.arrivalGoodsDate] as String),
      );
}
