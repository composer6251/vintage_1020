// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    _InventoryItem(
      id: json['id'] as String,
      itemImageUrls: (json['itemImageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      itemPurchaseDate: DateTime.parse(json['itemPurchaseDate'] as String),
      itemPurchasePrice: (json['itemPurchasePrice'] as num?)?.toDouble(),
      itemCategory: $enumDecode(
        _$InventoryCategoryEnumMap,
        json['itemCategory'],
      ),
      itemListingDate: json['itemListingDate'] == null
          ? null
          : DateTime.parse(json['itemListingDate'] as String),
      itemListingPrice: (json['itemListingPrice'] as num?)?.toDouble(),
      itemSoldPrice: (json['itemSoldPrice'] as num?)?.toDouble(),
      primaryImageUrl: json['primaryImageUrl'] as String?,
      itemDescription: json['itemDescription'] as String?,
      itemSoldDate: json['itemSoldDate'] == null
          ? null
          : DateTime.parse(json['itemSoldDate'] as String),
    );

Map<String, dynamic> _$InventoryItemToJson(_InventoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemImageUrls': instance.itemImageUrls,
      'itemPurchaseDate': instance.itemPurchaseDate.toIso8601String(),
      'itemPurchasePrice': instance.itemPurchasePrice,
      'itemCategory': _$InventoryCategoryEnumMap[instance.itemCategory]!,
      'itemListingDate': instance.itemListingDate?.toIso8601String(),
      'itemListingPrice': instance.itemListingPrice,
      'itemSoldPrice': instance.itemSoldPrice,
      'primaryImageUrl': instance.primaryImageUrl,
      'itemDescription': instance.itemDescription,
      'itemSoldDate': instance.itemSoldDate?.toIso8601String(),
    };

const _$InventoryCategoryEnumMap = {
  InventoryCategory.furniture: 'furniture',
  InventoryCategory.wallDecor: 'wallDecor',
  InventoryCategory.lamps: 'lamps',
  InventoryCategory.paintings: 'paintings',
  InventoryCategory.pictures: 'pictures',
  InventoryCategory.miscellaneous: 'miscellaneous',
};
