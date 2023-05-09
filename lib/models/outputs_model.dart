import 'package:equatable/equatable.dart';

const String outputsTable = 'outputs';

class OutputsFields {
  static const String id = 'id';
  static const String personId = 'personId';
  static const String date = 'date';

  static const List<String> values = [
    id,
    personId,
    date,
  ];
}

class OutputsModel extends Equatable {
  final int? id;
  final int personId;
  final DateTime date;
  const OutputsModel({
    this.id,
    required this.personId,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        personId,
        date,
      ];

  OutputsModel copyWith({
    int? id,
    int? personId,
    DateTime? date,
  }) {
    return OutputsModel(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      OutputsFields.id: id,
      OutputsFields.personId: personId,
      OutputsFields.date: date.toIso8601String(),
    };
  }

  static OutputsModel fromMap(Map<String, dynamic> map) {
    return OutputsModel(
      id: map[OutputsFields.id] != null ? map[OutputsFields.id] as int : null,
      personId: map[OutputsFields.personId] as int,
      date: DateTime.parse(map[OutputsFields.date] as String),
    );
  }
}
