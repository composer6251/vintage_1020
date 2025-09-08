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
    required List<String> itemImageUrls,
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
// Getter for itemId, defaults to 0 if id is null
  /// Convert a JSON object into an [InventoryItem] instance.
  /// This enables type-safe reading of the API response.
  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

}
