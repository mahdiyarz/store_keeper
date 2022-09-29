final String lakingTable = 'laking';

class LakingFields {
  static const String lakingId = 'lakingId';
  static const String lakingDate = 'lakingDate';
  static const String lakingNum = 'lakingNum';
}

class LakingModel {
  final int lakingId;
  final DateTime lakingDate;
  final int lakingNum;

  LakingModel(
    this.lakingId,
    this.lakingDate,
    this.lakingNum,
  );
}
