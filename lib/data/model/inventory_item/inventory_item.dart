import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vintage_1020/constants/inventory_categories.dart';

// tells riverpod these are part of the code for this file.
part 'inventory_item.freezed.dart';
part 'inventory_item.g.dart';

// _$InventoryItem is a mixin that allows InventoryItem to inherit properties from the generated class (part 'inventory_item_rp.freezed.dart')
@freezed
sealed class InventoryItem with _$InventoryItem {
  const factory InventoryItem({
    num? id, // Optional ID for the item
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
  }) = _InventoryItem; // Freezed generates private implementation class

  /// Convert a JSON object into an [InventoryItem] instance.
  /// This enables type-safe reading of the API response.
  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

    factory InventoryItem.fromFirestore(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

    factory InventoryItem.toFirestore(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

  //   factory InventoryItem.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot,P
  //     SnapshotOptions? options,
  //   ) {
  //     final data = snapshot.data();
  //     return InventoryItem(
  //       id: data?['id'],
  //       itemPurchaseDate: data?['itemPurchaseDate'],
  //       itemPurchasePrice: data?['itemPurchasePrice'],
  //       itemCategory: data?['itemCategory'],
  //       itemListingDate: data?['itemListingDate'],
  //       itemListingPrice: data?['itemListingPrice'],
  //       itemSoldPrice: data?['itemSoldPrice'],
  //       primaryImageUrl: data?['primaryImageUrl'],
  //       itemDescription: data?['itemDescription'],
  //       itemImageUrls:
  //           data?['itemImageUrls'] is Iterable ? List.from(data?['itemImageUrls']) : null,
  //       itemDimensions:
  //           data?['itemDimensions'] is Iterable ? Map.from(data?['itemDimensions']) : null,
  //     );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (id != null) "id": id,
  //     "itemPurchaseDate": itemPurchaseDate,
  //     if (itemPurchasePrice != null) "itemPurchasePrice": itemPurchasePrice,
  //     "itemCategory": itemCategory,
  //     if (itemListingDate != null) "itemListingDate": itemListingDate,
  //     if (itemListingPrice != null) "itemListingPrice": itemListingPrice,
  //     if (itemSoldPrice != null) "itemSoldPrice": itemSoldPrice,
  //     if (itemPurchasePrice != null) "itemPurchasePrice": itemPurchasePrice,
  //     if (primaryImageUrl != null) "primaryImageUrl": primaryImageUrl,
  //     if (itemDescription != null) "itemDescription": itemDescription,
  //     if (itemImageUrls != null) "itemImageUrls": itemImageUrls,
  //     if (itemDimensions != null) "itemDimensions": itemDimensions,
  //   };
  // }
}
