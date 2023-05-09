import 'package:equatable/equatable.dart';

const String warehouseHandlingTable = 'warehouseHandling';

class WarehouseHandlingFields {
  static const String id = 'id';
  static const String warehouseId = 'warehouseId';
  static const String date = 'date';
  static const String countNumber = 'countNumber';

  static const List<String> values = [
    id,
    warehouseId,
    date,
    countNumber,
  ];
}

class WarehouseHandlingModel extends Equatable {
  final int? id;
  final int warehouseId;
  final DateTime date;
  final int countNumber;
  const WarehouseHandlingModel({
    this.id,
    required this.warehouseId,
    required this.date,
    required this.countNumber,
  });

  @override
  List<Object?> get props => [
        id,
        warehouseId,
        date,
        countNumber,
      ];

  WarehouseHandlingModel copyWith({
    int? id,
    int? warehouseId,
    DateTime? date,
    int? countNumber,
  }) {
    return WarehouseHandlingModel(
      id: id ?? this.id,
      warehouseId: warehouseId ?? this.warehouseId,
      date: date ?? this.date,
      countNumber: countNumber ?? this.countNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      WarehouseHandlingFields.id: id,
      WarehouseHandlingFields.warehouseId: warehouseId,
      WarehouseHandlingFields.date: date.toIso8601String(),
      WarehouseHandlingFields.countNumber: countNumber,
    };
  }

  static WarehouseHandlingModel fromMap(Map<String, dynamic> map) {
    return WarehouseHandlingModel(
      id: map[WarehouseHandlingFields.id] != null
          ? map[WarehouseHandlingFields.id] as int
          : null,
      warehouseId: map[WarehouseHandlingFields.warehouseId] as int,
      date: DateTime.parse(map[WarehouseHandlingFields.date] as String),
      countNumber: map[WarehouseHandlingFields.countNumber] as int,
    );
  }
}
