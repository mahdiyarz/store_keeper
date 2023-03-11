import 'package:equatable/equatable.dart';

const String transfersTable = 'transfers';

class TransfersField {
  static const String id = 'id';
  static const String personId = 'personId';
  static const String boxes = 'boxes';
  static const String date = 'date';

  static const List<String> values = [
    id,
    personId,
    boxes,
    date,
  ];
}

class TransfersModel extends Equatable {
  final int? id;
  final int personId;
  final int boxes;
  final DateTime date;
  const TransfersModel({
    this.id,
    required this.personId,
    required this.boxes,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        personId,
        boxes,
        date,
      ];

  TransfersModel copyWith({
    int? id,
    int? personId,
    int? boxes,
    DateTime? date,
  }) {
    return TransfersModel(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      boxes: boxes ?? this.boxes,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'personId': personId,
      'boxes': boxes,
      'date': date.toIso8601String,
    };
  }

  static TransfersModel fromJson(Map<String, dynamic> map) {
    return TransfersModel(
      id: map['id'] != null ? map['id'] as int : null,
      personId: map['personId'] as int,
      boxes: map['boxes'] as int,
      date: DateTime.parse(map['date'] as String),
    );
  }
}
