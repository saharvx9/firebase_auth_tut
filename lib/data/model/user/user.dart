import 'package:firebase_auth_tut/data/model/gender.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "date", fromJson: _fromDateJson, toJson: _toDateJson)
  final DateTime? date;
  @JsonKey(name: "gender")
  final Gender? gender;
  @JsonKey(name: "image_url")
  String? imageUrl;

  User(this.id, this.name, this.email, this.date, this.gender, this.imageUrl);

  String get dateStr => date != null ? DateFormat("dd/mm/yyyy").format(date!) : "";

  factory User.fromJsonId(String id,Map<String, dynamic> json){
    json["id"] = id;
    return _$UserFromJson(json);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime? _fromDateJson(int? timestamp) {
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  static int? _toDateJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.microsecondsSinceEpoch;
  }
}
