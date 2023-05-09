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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TransfersField.id: id,
      TransfersField.personId: personId,
      TransfersField.boxes: boxes,
      TransfersField.date: date.toIso8601String,
    };
  }

  static TransfersModel fromMap(Map<String, dynamic> map) {
    return TransfersModel(
      id: map[TransfersField.id] != null ? map[TransfersField.id] as int : null,
      personId: map[TransfersField.personId] as int,
      boxes: map[TransfersField.boxes] as int,
      date: DateTime.parse(map[TransfersField.date] as String),
    );
  }
}
