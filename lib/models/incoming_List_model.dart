import 'package:equatable/equatable.dart';

const String incomingListTable = 'incomingList';

class IncomingListFields {
  static const List<String> values = [
    incomingListId,
    personId,
    numOfBoxes,
    incomingListDate,
  ];

  static const String incomingListId = 'incomingListId';
  static const String personId = 'personId';
  static const String numOfBoxes = 'numOfBoxes';
  static const String incomingListDate = 'incomingListDate';
}

class IncomingListModel extends Equatable {
  final int? incomingListId;
  final int personId;
  final int numOfBoxes;
  final DateTime incomingListDate;

  const IncomingListModel({
    this.incomingListId,
    required this.personId,
    required this.numOfBoxes,
    required this.incomingListDate,
  });

  Map<String, Object?> toJson() => {
        IncomingListFields.incomingListId: incomingListId,
        IncomingListFields.personId: personId,
        IncomingListFields.numOfBoxes: numOfBoxes,
        IncomingListFields.incomingListDate: incomingListDate.toIso8601String(),
      };

  IncomingListModel copy({
    int? incomingListId,
    int? personId,
    int? numOfBoxes,
    DateTime? incomingListDate,
  }) =>
      IncomingListModel(
        incomingListId: incomingListId ?? incomingListId,
        personId: personId ?? this.personId,
        numOfBoxes: numOfBoxes ?? this.numOfBoxes,
        incomingListDate: incomingListDate ?? this.incomingListDate,
      );

  static IncomingListModel fromJson(Map<String, Object?> json) =>
      IncomingListModel(
        incomingListId: json[IncomingListFields.incomingListId] as int,
        personId: json[IncomingListFields.personId] as int,
        numOfBoxes: json[IncomingListFields.numOfBoxes] as int,
        incomingListDate:
            DateTime.parse(json[IncomingListFields.incomingListDate] as String),
      );

  @override
  List<Object?> get props => [
        incomingListId,
        personId,
        numOfBoxes,
        incomingListDate,
      ];
}
