const String brandsTable = 'brands';

class BrandsFields {
  static const List<String> values = [
    brandId,
    brandName,
  ];

  static const String brandId = 'brandId';
  static const String brandName = 'brandName';
}

class BrandsModel {
  final int? brandId;
  final String brandName;

  BrandsModel({
    this.brandId,
    required this.brandName,
  });

  Map<String, Object?> toJson() => {
        BrandsFields.brandId: brandId,
        BrandsFields.brandName: brandName,
      };

  BrandsModel copy({
    int? brandId,
    String? brandName,
  }) =>
      BrandsModel(
          brandId: brandId ?? this.brandId,
          brandName: brandName ?? this.brandName);

  static BrandsModel fromJson(Map<String, Object?> json) => BrandsModel(
        brandId: json[BrandsFields.brandId] as int,
        brandName: json[BrandsFields.brandName] as String,
      );
}
