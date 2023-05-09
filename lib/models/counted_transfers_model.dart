import 'package:equatable/equatable.dart';

const String countedTransfersTable = 'countedTransfers';

class CountedTransfersFields {
  static const String id = 'id';
  static const String transferId = 'transferId';
  static const String goodId = 'goodId';
  static const String withBoxes = 'withBoxes';
  static const String withoutBox = 'withoutBox';
  static const String totalCounted = 'totalCounted';

  static const List<String> values = [
    id,
    transferId,
    goodId,
    withBoxes,
    withoutBox,
    totalCounted,
  ];
}

class CountedTransfersModel extends Equatable {
  final int? id;
  final int transferId;
  final int goodId;
  final int? withBoxes;
  final int withoutBox;
  final int totalCounted;
  const CountedTransfersModel({
    this.id,
    required this.transferId,
    required this.goodId,
    this.withBoxes,
    required this.withoutBox,
    required this.totalCounted,
  });

  @override
  List<Object?> get props => [
        id,
        transferId,
        goodId,
        withBoxes,
        withoutBox,
        totalCounted,
      ];

  CountedTransfersModel copyWith({
    int? id,
    int? transferId,
    int? goodId,
    int? withBoxes,
    int? withoutBox,
    int? totalCounted,
  }) {
    return CountedTransfersModel(
      id: id ?? this.id,
      transferId: transferId ?? this.transferId,
      goodId: goodId ?? this.goodId,
      withBoxes: withBoxes ?? this.withBoxes,
      withoutBox: withoutBox ?? this.withoutBox,
      totalCounted: totalCounted ?? this.totalCounted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CountedTransfersFields.id: id,
      CountedTransfersFields.transferId: transferId,
      CountedTransfersFields.goodId: goodId,
      CountedTransfersFields.withBoxes: withBoxes,
      CountedTransfersFields.withoutBox: withoutBox,
      CountedTransfersFields.totalCounted: totalCounted,
    };
  }

  static CountedTransfersModel fromMap(Map<String, dynamic> map) {
    return CountedTransfersModel(
      id: map[CountedTransfersFields.id] != null
          ? map[CountedTransfersFields.id] as int
          : null,
      transferId: map[CountedTransfersFields.transferId] as int,
      goodId: map[CountedTransfersFields.goodId] as int,
      withBoxes: map[CountedTransfersFields.withBoxes] != null
          ? map[CountedTransfersFields.withBoxes] as int
          : null,
      withoutBox: map[CountedTransfersFields.withoutBox] as int,
      totalCounted: map[CountedTransfersFields.totalCounted] as int,
    );
  }
}
