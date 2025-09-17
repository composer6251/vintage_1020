import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vintage_1020/data/model/json_converters/TimestampConverter.dart';

sealed class InventoryItemLocal {
  factory InventoryItemLocal({
    num? id, // Optional ID for the item
    List<File>? itemImages,
    List<String>? itemImageUrls,
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
  }) {
    return InventoryItemLocal(
      id: id,
      itemImages: itemImages ?? [],
      itemImageUrls: itemImageUrls ?? [],
      itemPurchaseDate: itemPurchaseDate,
      itemPurchasePrice: itemPurchasePrice,
      itemCategory: itemCategory,
      itemListingDate: itemListingDate,
      itemListingPrice: itemListingPrice,
      itemSoldPrice: itemSoldPrice,
      primaryImageUrl: primaryImageUrl,
      itemDescription: itemDescription,
      itemSoldDate: itemSoldDate,
      itemDimensions: itemDimensions,
    );
  }

  // / Convert a JSON object into an [InventoryItem] instance.
  // / This enables type-safe reading of the API response.
  // factory InventoryItemImage.fromJson(Map<String, dynamic> json) =>
  //     _InventoryItemImage(json);

  /// Convert a JSON object into an [InventoryItemLocal] instance.
  /// This enables type-safe reading of the API response.
  factory InventoryItemLocal.inventoryItemImageFromJson(
    Map<String, dynamic> json,
  ) => InventoryItemLocal(
    id: json['id'] as num?,
    itemImages: (json['itemImageUrls'] as List<File>),
    itemPurchaseDate: const TimestampConverter().fromJson(
      json['itemPurchaseDate'],
    ),
    itemPurchasePrice: (json['itemPurchasePrice'] as num?)?.toDouble(),
    itemCategory: json['itemCategory'] as String,
    itemListingDate: const TimestampConverter().fromJson(
      json['itemListingDate'],
    ),
    itemListingPrice: (json['itemListingPrice'] as num?)?.toDouble(),
    itemSoldPrice: (json['itemSoldPrice'] as num?)?.toDouble(),
    primaryImageUrl: json['primaryImageUrl'] as String?,
    itemDescription: json['itemDescription'] as String?,
    itemSoldDate: const TimestampConverter().fromJson(json['itemSoldDate']),
    itemDimensions: (json['itemDimensions'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );

  factory InventoryItemLocal.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    print('inventory ${data?['inventory']}');

    InventoryItemLocal item = InventoryItemLocal(
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
      itemImages: data?['itemImageUrls'] as List<File>,
      itemDimensions: data?['itemDimensions'] is Iterable
          ? Map.from(data?['itemDimensions'])
          : null,
    );

    return item;
  }
}

  // Map<String, dynamic> toFirestore(InventoryItemImage item) {
  //   return {
  //     if (item.id != null) "id": item.id,
  //     "itemPurchaseDate": item.itemPurchaseDate,
  //     if (item.itemPurchasePrice != null) "itemPurchasePrice": item.itemPurchasePrice,
  //     "itemCategory": item.itemCategory,
  //     if (item.itemListingDate != null) "itemListingDate": item.itemListingDate,
  //     if (item.itemListingPrice != null) "itemListingPrice": item.itemListingPrice,
  //     if (item.itemSoldPrice != null) "itemSoldPrice": item.itemSoldPrice,
  //     if (item.itemPurchasePrice != null) "itemPurchasePrice": item.itemPurchasePrice,
  //     if (item.itemSoldDate != null) "itemSoldDate": item.itemSoldDate,
  //     if (item.primaryImageUrl != null) "primaryImageUrl": item.primaryImageUrl,
  //     if (item.itemDescription != null) "itemDescription": item.itemDescription,
  //     if (item.itemImages != null) "itemImageUrls": item.itemImages,
  //     if (item.itemDimensions != null) "itemDimensions": item.itemDimensions,
  //   };
  // }
