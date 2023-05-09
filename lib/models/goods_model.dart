import 'package:equatable/equatable.dart';

const String goodsTable = 'goods';

class GoodsFields {
  static const List<String> values = [
    id,
    name,
    latin,
    brandId,
    numInBox,
    barcode,
    accountingCode,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String latin = 'latin';
  static const String brandId = 'brandId';
  static const String numInBox = 'numInBox';
  static const String barcode = 'barcode';
  static const String accountingCode = 'accountingCode';
}

class GoodsModel extends Equatable {
  final int? id;
  final String name;
  final String latin;
  final int brandId;
  final int numInBox;
  final int? barcode;
  final int? accountingCode;

  const GoodsModel({
    this.id,
    required this.name,
    required this.latin,
    required this.brandId,
    required this.numInBox,
    this.barcode,
    this.accountingCode,
  });

  Map<String, Object?> toMap() => {
        GoodsFields.id: id,
        GoodsFields.name: name,
        GoodsFields.latin: latin,
        GoodsFields.brandId: brandId,
        GoodsFields.numInBox: numInBox,
        GoodsFields.barcode: barcode,
        GoodsFields.accountingCode: accountingCode,
      };

  GoodsModel copyWith({
    int? id,
    String? name,
    String? latin,
    int? brandId,
    int? numInBox,
    int? barcode,
    int? accountingCode,
  }) =>
      GoodsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        latin: latin ?? this.latin,
        brandId: brandId ?? this.brandId,
        numInBox: numInBox ?? this.numInBox,
        barcode: barcode ?? this.barcode,
        accountingCode: accountingCode ?? this.accountingCode,
      );

  static GoodsModel fromMap(Map<String, Object?> json) => GoodsModel(
        id: json[GoodsFields.id] as int?,
        name: json[GoodsFields.name] as String,
        latin: json[GoodsFields.latin] as String,
        brandId: json[GoodsFields.brandId] as int,
        numInBox: json[GoodsFields.numInBox] as int,
        barcode: json[GoodsFields.barcode] as int?,
        accountingCode: json[GoodsFields.accountingCode] as int?,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        latin,
        brandId,
        numInBox,
        barcode,
        accountingCode,
      ];
}
