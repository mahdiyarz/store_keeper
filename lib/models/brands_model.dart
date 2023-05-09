import 'package:equatable/equatable.dart';

const String brandsTable = 'brands';

class BrandsFields {
  static const List<String> values = [
    id,
    name,
    latin,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String latin = 'latin';
}

class BrandsModel extends Equatable {
  final int? id;
  final String name;
  final String latin;

  const BrandsModel({
    this.id,
    required this.name,
    required this.latin,
  });

  Map<String, Object?> toMap() => {
        BrandsFields.id: id,
        BrandsFields.name: name,
        BrandsFields.latin: latin,
      };

  BrandsModel copyWith({
    int? id,
    String? name,
    String? latin,
  }) =>
      BrandsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        latin: latin ?? this.latin,
      );

  static BrandsModel fromMap(Map<String, Object?> json) => BrandsModel(
        id: json[BrandsFields.id] as int?,
        name: json[BrandsFields.name] as String,
        latin: json[BrandsFields.latin] as String,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        latin,
      ];
}
