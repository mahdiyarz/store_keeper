import 'package:equatable/equatable.dart';

const String goodsTable = 'goods';

class GoodsFields {
  static const List<String> values = [
    goodId,
    goodName,
    goodLatinName,
    brandId,
    numInBox,
    barcode,
    accountingCode,
  ];

  static const String goodId = 'goodId';
  static const String goodName = 'goodName';
  static const String goodLatinName = 'goodLatinName';
  static const String brandId = 'brandId';
  static const String numInBox = 'numInBox';
  static const String barcode = 'barcode';
  static const String accountingCode = 'accountingCode';
}

class GoodsModel extends Equatable {
  final int? goodId;
  final String goodName;
  final String goodLatinName;
  final int brandId;
  final int numInBox;
  final int? barcode;
  final int? accountingCode;

  const GoodsModel({
    this.goodId,
    required this.goodName,
    required this.goodLatinName,
    required this.brandId,
    required this.numInBox,
    this.barcode,
    this.accountingCode,
  });

  Map<String, Object?> toJson() => {
        GoodsFields.goodId: goodId,
        GoodsFields.goodName: goodName,
        GoodsFields.goodLatinName: goodLatinName,
        GoodsFields.brandId: brandId,
        GoodsFields.numInBox: numInBox,
        GoodsFields.barcode: barcode,
        GoodsFields.accountingCode: accountingCode,
      };

  GoodsModel copy({
    int? goodId,
    String? goodName,
    String? goodLatinName,
    int? brandId,
    int? numInBox,
    int? barcode,
    int? accountingCode,
  }) =>
      GoodsModel(
        goodId: goodId ?? this.goodId,
        goodName: goodName ?? this.goodName,
        goodLatinName: goodLatinName ?? this.goodLatinName,
        brandId: brandId ?? this.brandId,
        numInBox: numInBox ?? this.numInBox,
        barcode: barcode ?? this.barcode,
        accountingCode: accountingCode ?? this.accountingCode,
      );

  static GoodsModel fromJson(Map<String, Object?> json) => GoodsModel(
        goodId: json[GoodsFields.goodId] as int?,
        goodName: json[GoodsFields.goodName] as String,
        goodLatinName: json[GoodsFields.goodLatinName] as String,
        brandId: json[GoodsFields.brandId] as int,
        numInBox: json[GoodsFields.numInBox] as int,
        barcode: json[GoodsFields.barcode] as int?,
        accountingCode: json[GoodsFields.accountingCode] as int?,
      );

  @override
  List<Object?> get props => [
        goodId,
        goodName,
        goodLatinName,
        brandId,
        numInBox,
        barcode,
        accountingCode,
      ];
}
