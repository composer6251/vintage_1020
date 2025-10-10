import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vintage_1020/domain/json_converters/TimestampConverter.dart';

// tells riverpod these are part of the code for this file.
part 'inventory_item.freezed.dart';
part 'inventory_item.g.dart';

// _$InventoryItem is a mixin that allows InventoryItem to inherit properties from the generated class (part 'inventory_item_rp.freezed.dart')
@freezed
sealed class InventoryItem with _$InventoryItem {
   factory InventoryItem({
    num? id, // Optional ID for the item
    @Default([])
    List<String> itemImageUrls,
    required DateTime itemPurchaseDate,
    double? itemPurchasePrice,
    required String itemCategory,
    DateTime? itemListingDate,
    double? itemListingPrice,
    double? itemSoldPrice,
    String? primaryImageUrl,    
    String? itemDescription,
    DateTime? itemSoldDate,
    Map<String, String>? itemDimensions,
  }) = _InventoryItem; // Freezed generates private implementation class

  /// Convert a JSON object into an [InventoryItem] instance.
  /// This enables type-safe reading of the API response.
  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

  /// Convert a JSON object into an [InventoryItem] instance.
  /// This enables type-safe reading of the API response.
factory InventoryItem.inventoryItemFromJson(Map<String, dynamic> json) =>
    _InventoryItem(
      id: json['id'] as num?,
      itemImageUrls:
          (json['itemImageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      itemPurchaseDate: const TimestampConverter().fromJson(json['itemPurchaseDate']),
      itemPurchasePrice: (json['itemPurchasePrice'] as num?)?.toDouble(),
      itemCategory: json['itemCategory'] as String,
      itemListingDate: const TimestampConverter().fromJson(json['itemListingDate']),
      // itemListingDate: json['itemListingDate'] == null
      //     ? null
      //     : DateTime.parse(json['itemListingDate'] as String),
      itemListingPrice: (json['itemListingPrice'] as num?)?.toDouble(),
      itemSoldPrice: (json['itemSoldPrice'] as num?)?.toDouble(),
      primaryImageUrl: json['primaryImageUrl'] as String?,
      itemDescription: json['itemDescription'] as String?,
      itemSoldDate: const TimestampConverter().fromJson(json['itemSoldDate']),
      itemDimensions: (json['itemDimensions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

    factory InventoryItem.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
    ) {
      final data = snapshot.data();

      print('inventory ${data?['inventory']}');

    InventoryItem item = InventoryItem(
        id: data?['id'],
        itemPurchaseDate: data?['itemPurchaseDate'],
        itemPurchasePrice: data?['itemPurchasePrice'],
        itemCategory: data?['itemCategory'],
        itemListingDate: data?['itemListingDate'],
        itemListingPrice: data?['itemListingPrice'],
        itemSoldPrice: data?['itemSoldPrice'],
        itemSoldDate: data?['itemSoldDate'],
        primaryImageUrl: data?['primaryImageUrl'],
        itemDescription: data?['itemDescription'],
        itemImageUrls:
            data?['itemImageUrls'] as List<String>,
        itemDimensions:
            data?['itemDimensions'] is Iterable ? Map.from(data?['itemDimensions']) : null,
      );

      return item;
  }
}

  Map<String, dynamic> toFirestore(InventoryItem item) {
    return {
      if (item.id != null) "id": item.id,
      "itemPurchaseDate": item.itemPurchaseDate,
      if (item.itemPurchasePrice != null) "itemPurchasePrice": item.itemPurchasePrice,
      "itemCategory": item.itemCategory,
      if (item.itemListingDate != null) "itemListingDate": item.itemListingDate,
      if (item.itemListingPrice != null) "itemListingPrice": item.itemListingPrice,
      if (item.itemSoldPrice != null) "itemSoldPrice": item.itemSoldPrice,
      if (item.itemPurchasePrice != null) "itemPurchasePrice": item.itemPurchasePrice,
      if (item.itemSoldDate != null) "itemSoldDate": item.itemSoldDate,
      if (item.primaryImageUrl != null) "primaryImageUrl": item.primaryImageUrl,
      if (item.itemDescription != null) "itemDescription": item.itemDescription,
      "itemImageUrls": item.itemImageUrls,
      if (item.itemDimensions != null) "itemDimensions": item.itemDimensions,
    };
  }
