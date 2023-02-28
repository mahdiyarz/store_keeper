import 'package:equatable/equatable.dart';

const String personsTable = 'persons';

class PersonsFields {
  static const List<String> values = [
    personId,
    personName,
    personDescription,
  ];

  static const String personId = 'personId';
  static const String personName = 'personName';
  static const String personDescription = 'personDescription';
}

class PersonsModel extends Equatable {
  final int? personId;
  final String personName;
  final String? personDescription;

  const PersonsModel({
    this.personId,
    required this.personName,
    this.personDescription,
  });

  @override
  List<Object?> get props => [
        personId,
        personName,
        personDescription,
      ];

  PersonsModel copyWith({
    int? personId,
    String? personName,
    String? personDescription,
  }) {
    return PersonsModel(
      personId: personId ?? this.personId,
      personName: personName ?? this.personName,
      personDescription: personDescription ?? this.personDescription,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'personId': personId,
      'personName': personName,
      'personDescription': personDescription,
    };
  }

  static PersonsModel fromJson(Map<String, dynamic> json) {
    return PersonsModel(
      personId: json['personId'] != null ? json['personId'] as int : null,
      personName: json['personName'] as String,
      personDescription: json['personDescription'] != null
          ? json['personDescription'] as String
          : null,
    );
  }
}
