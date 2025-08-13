// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  userEmail: json['userEmail'] as String,
  userName: json['userName'] as String?,
  userInventoryId: json['userInventoryId'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'userEmail': instance.userEmail,
  'userName': instance.userName,
  'userInventoryId': instance.userInventoryId,
};
