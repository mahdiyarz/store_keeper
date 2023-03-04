const String warehousesTable = 'warehouses';

class WarehousesFields {
  static const String warehouseId = 'warehouseId';
  static const String warehouseName = 'warehouseName';

  static const List<String> values = [
    warehouseId,
    warehouseName,
  ];
}

class WarehousesModel {
  final int? warehouseId;
  final String warehouseName;

  WarehousesModel({
    this.warehouseId,
    required this.warehouseName,
  });

  WarehousesModel copyWith({
    int? warehouseId,
    String? warehouseName,
  }) {
    return WarehousesModel(
      warehouseId: warehouseId ?? this.warehouseId,
      warehouseName: warehouseName ?? this.warehouseName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'warehouseId': warehouseId,
      'warehouseName': warehouseName,
    };
  }

  static WarehousesModel fromMap(Map<String, dynamic> map) {
    return WarehousesModel(
      warehouseId:
          map['warehouseId'] != null ? map['warehouseId'] as int : null,
      warehouseName: map['warehouseName'] as String,
    );
  }
}
