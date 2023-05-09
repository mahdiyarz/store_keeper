const String warehousesTable = 'warehouses';

class WarehousesFields {
  static const String id = 'id';
  static const String name = 'name';

  static const List<String> values = [
    id,
    name,
  ];
}

class WarehousesModel {
  final int? id;
  final String name;

  WarehousesModel({
    this.id,
    required this.name,
  });

  WarehousesModel copyWith({
    int? id,
    String? name,
  }) {
    return WarehousesModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      WarehousesFields.id: id,
      WarehousesFields.name: name,
    };
  }

  static WarehousesModel fromMap(Map<String, dynamic> map) {
    return WarehousesModel(
      id: map[WarehousesFields.id] != null
          ? map[WarehousesFields.id] as int
          : null,
      name: map[WarehousesFields.name] as String,
    );
  }
}
