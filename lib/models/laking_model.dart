const String lakingTable = 'laking';

class LakingFields {
  static const String lakingId = 'lakingId';
  static const String lakingDate = 'lakingDate';
  static const String lakingNum = 'lakingNum';
}

class LakingModel {
  final int lakingId;
  final DateTime lakingDate;
  final int lakingNum;

  LakingModel({
    required this.lakingId,
    required this.lakingDate,
    required this.lakingNum,
  });

  Map<String, Object> toJson() => {
        LakingFields.lakingId: lakingId,
        LakingFields.lakingDate: lakingDate.toIso8601String(),
        LakingFields.lakingNum: lakingNum,
      };

  LakingModel copy({
    int? lakingId,
    DateTime? lakingDate,
    int? lakingNum,
  }) =>
      LakingModel(
        lakingId: lakingId ?? this.lakingId,
        lakingDate: lakingDate ?? this.lakingDate,
        lakingNum: lakingNum ?? this.lakingNum,
      );

  static LakingModel fromJson(Map<String, Object?> json) => LakingModel(
        lakingId: json[LakingFields.lakingId] as int,
        lakingDate: DateTime.parse(json[LakingFields.lakingDate] as String),
        lakingNum: json[LakingFields.lakingNum] as int,
      );
}
