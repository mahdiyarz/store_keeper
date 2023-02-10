import 'package:equatable/equatable.dart';

const String incomingListTable = 'incomingList';

class IncomingListFields {
  static const List<String> values = [
    incomingListId,
    brandId,
    numOfBoxes,
    incomingListDate,
  ];

  static const String incomingListId = 'incomingListId';
  static const String brandId = 'brandId';
  static const String numOfBoxes = 'numOfBoxes';
  static const String incomingListDate = 'incomingListDate';
}

class IncomingListModel extends Equatable {
  final int? incomingListId;
  final int brandId;
  final int numOfBoxes;
  final DateTime incomingListDate;

  const IncomingListModel({
    this.incomingListId,
    required this.brandId,
    required this.numOfBoxes,
    required this.incomingListDate,
  });

  Map<String, Object?> toJson() => {
        IncomingListFields.incomingListId: incomingListId,
        IncomingListFields.brandId: brandId,
        IncomingListFields.numOfBoxes: numOfBoxes,
        IncomingListFields.incomingListDate: incomingListDate.toIso8601String(),
      };

  IncomingListModel copy({
    int? incomingListId,
    int? brandId,
    int? numOfBoxes,
    DateTime? incomingListDate,
  }) =>
      IncomingListModel(
        incomingListId: incomingListId ?? incomingListId,
        brandId: brandId ?? this.brandId,
        numOfBoxes: numOfBoxes ?? this.numOfBoxes,
        incomingListDate: incomingListDate ?? this.incomingListDate,
      );

  static IncomingListModel fromJson(Map<String, Object?> json) =>
      IncomingListModel(
        incomingListId: json[IncomingListFields.incomingListId] as int,
        brandId: json[IncomingListFields.brandId] as int,
        numOfBoxes: json[IncomingListFields.numOfBoxes] as int,
        incomingListDate:
            DateTime.parse(json[IncomingListFields.incomingListDate] as String),
      );

  @override
  List<Object?> get props => [
        incomingListId,
        brandId,
        numOfBoxes,
        incomingListDate,
      ];
}
