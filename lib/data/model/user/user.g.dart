// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['name'] as String?,
      json['email'] as String?,
      User._fromDateJson(json['date'] as int?),
      $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      json['image_url'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'date': User._toDateJson(instance.date),
      'gender': _$GenderEnumMap[instance.gender],
      'image_url': instance.imageUrl,
    };

const _$GenderEnumMap = {
  Gender.female: 'female',
  Gender.male: 'male',
  Gender.unknown: 'unknown',
};
