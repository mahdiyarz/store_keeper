import 'package:equatable/equatable.dart';

const String personsTable = 'persons';

class PersonsFields {
  static const List<String> values = [
    id,
    name,
    description,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
}

class PersonsModel extends Equatable {
  final int? id;
  final String name;
  final String? description;

  const PersonsModel({
    this.id,
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
      ];

  PersonsModel copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return PersonsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PersonsFields.id: id,
      PersonsFields.name: name,
      PersonsFields.description: description,
    };
  }

  static PersonsModel fromMap(Map<String, dynamic> json) {
    return PersonsModel(
      id: json[PersonsFields.id] != null ? json[PersonsFields.id] as int : null,
      name: json[PersonsFields.name] as String,
      description: json[PersonsFields.description] != null
          ? json[PersonsFields.description] as String
          : null,
    );
  }
}
