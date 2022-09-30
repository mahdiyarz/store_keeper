const String goodsTable = 'goods';

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

  GoodsModel({
    required this.goodId,
    required this.goodName,
    required this.brandId,
    required this.numInBox,
    required this.barcode,
  });

  Map<String, Object> toJson() => {
        GoodsFields.goodId: goodId,
        GoodsFields.goodName: goodName,
        GoodsFields.brandId: brandId,
        GoodsFields.numInBox: numInBox,
        GoodsFields.barcode: barcode,
      };

  GoodsModel copy({
    int? goodId,
    String? goodName,
    int? brandId,
    int? numInBox,
    BigInt? barcode,
  }) =>
      GoodsModel(
        goodId: goodId ?? this.goodId,
        goodName: goodName ?? this.goodName,
        brandId: brandId ?? this.brandId,
        numInBox: numInBox ?? this.numInBox,
        barcode: barcode ?? this.barcode,
      );

  static GoodsModel fromJson(Map<String, Object?> json) => GoodsModel(
        goodId: json[GoodsFields.goodId] as int,
        goodName: json[GoodsFields.goodName] as String,
        brandId: json[GoodsFields.brandId] as int,
        numInBox: json[GoodsFields.numInBox] as int,
        barcode: json[GoodsFields.barcode] as BigInt,
      );
}
