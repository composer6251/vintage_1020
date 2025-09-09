// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserCollection _$UserCollectionFromJson(Map<String, dynamic> json) =>
    _UserCollection(
      username: json['username'] as String,
      inventoryId: json['inventoryId'] as String,
      inventory: (json['inventory'] as List<dynamic>)
          .map((e) => InventoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserCollectionToJson(_UserCollection instance) =>
    <String, dynamic>{
      'username': instance.username,
      'inventoryId': instance.inventoryId,
      'inventory': instance.inventory,
    };
