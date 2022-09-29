final String brandsTable = 'brands';

class BrandsFields {
  static const String brandId = 'brandId';
  static const String brandName = 'brandName';
}

class BrandsModel {
  final int brandId;
  final String brandName;

  BrandsModel(
    this.brandId,
    this.brandName,
  );
}
