import 'package:equatable/equatable.dart';

const String incomingsTable = 'incomings';

class IncomingsFields {
  static const List<String> values = [
    incomingId,
    personId,
    boxes,
    incomingDate,
  ];

  static const String incomingId = 'incomingId';
  static const String personId = 'personId';
  static const String boxes = 'boxes';
  static const String incomingDate = 'incomingDate';
}

class IncomingsModel extends Equatable {
  final int? incomingId;
  final int personId;
  final int boxes;
  final DateTime incomingDate;

  const IncomingsModel({
    this.incomingId,
    required this.personId,
    required this.boxes,
    required this.incomingDate,
  });

  Map<String, Object?> toJson() => {
        IncomingsFields.incomingId: incomingId,
        IncomingsFields.personId: personId,
        IncomingsFields.boxes: boxes,
        IncomingsFields.incomingDate: incomingDate.toIso8601String(),
      };

  IncomingsModel copy({
    int? incomingId,
    int? personId,
    int? boxes,
    DateTime? incomingDate,
  }) =>
      IncomingsModel(
        incomingId: incomingId ?? incomingId,
        personId: personId ?? this.personId,
        boxes: boxes ?? this.boxes,
        incomingDate: incomingDate ?? this.incomingDate,
      );

  static IncomingsModel fromJson(Map<String, Object?> json) => IncomingsModel(
        incomingId: json[IncomingsFields.incomingId] as int,
        personId: json[IncomingsFields.personId] as int,
        boxes: json[IncomingsFields.boxes] as int,
        incomingDate:
            DateTime.parse(json[IncomingsFields.incomingDate] as String),
      );

  @override
  List<Object?> get props => [
        incomingId,
        personId,
        boxes,
        incomingDate,
      ];
}
