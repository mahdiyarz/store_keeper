const String brandsTable = 'brands';

class BrandsFields {
  static const List<String> values = [
    brandId,
    brandName,
    brandLatinName,
  ];

  static const String brandId = 'brandId';
  static const String brandName = 'brandName';
  static const String brandLatinName = 'brandLatinName';
}

class BrandsModel {
  final int? brandId;
  final String brandName;
  final String brandLatinName;

  const BrandsModel({
    this.brandId,
    required this.brandName,
    required this.brandLatinName,
  });

  Map<String, Object?> toJson() => {
        BrandsFields.brandId: brandId,
        BrandsFields.brandName: brandName,
        BrandsFields.brandLatinName: brandLatinName,
      };

  BrandsModel copy({
    int? brandId,
    String? brandName,
    String? brandLatinName,
  }) =>
      BrandsModel(
        brandId: brandId ?? this.brandId,
        brandName: brandName ?? this.brandName,
        brandLatinName: brandLatinName ?? this.brandLatinName,
      );

  static BrandsModel fromJson(Map<String, Object?> json) => BrandsModel(
        brandId: json[BrandsFields.brandId] as int,
        brandName: json[BrandsFields.brandName] as String,
        brandLatinName: json[BrandsFields.brandLatinName] as String,
      );
}
