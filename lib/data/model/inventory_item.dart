import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vintage_1020/constants/inventory_categories.dart';

// tells riverpod these are part of the code for this file.
part 'inventory_item.freezed.dart';
part 'inventory_item.g.dart';

// _$InventoryItem is a mixin that allows InventoryItem to inherit properties from the generated class (part 'inventory_item_rp.freezed.dart')
@freezed
sealed class InventoryItem with _$InventoryItem {
  const factory InventoryItem({
    required String id,
    required List<String> itemImageUrls,
    required DateTime itemPurchaseDate,
    required double itemPurchasePrice,
    required InventoryCategory itemCategory,
    DateTime? itemListingDate,
    double? itemListingPrice,
    double? itemSoldPrice,
    String? defaultItemImageUrl,
    String? itemDescription,
    DateTime? itemSoldDate,
  }) = _InventoryItem; // Freezed generates private implementation class

  /// Convert a JSON object into an [InventoryItem] instance.
  /// This enables type-safe reading of the API response.
  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);
}
