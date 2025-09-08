// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserCollection _$UserCollectionFromJson(Map<String, dynamic> json) =>
    _UserCollection(
      id: json['id'] as String?,
      username: json['username'] as String,
      inventoryId: json['inventoryId'] as String,
    );

Map<String, dynamic> _$UserCollectionToJson(_UserCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'inventoryId': instance.inventoryId,
    };
