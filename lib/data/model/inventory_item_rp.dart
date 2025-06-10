

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'inventory_item_rp.freezed.dart';
// part 'inventory_item_rp.g.dart';

// /// The response of the `GET /api/activity` endpoint.
// ///
// /// It is defined using `freezed` and `json_serializable`.
// @freezed
// sealed class InventoryItem with _$InventoryItem {
//   factory InventoryItem({
//     required String key,
//     required String activity,
//     required String type,
//     required int participants,
//     required double price,
//   }) = _InventoryItem;

//   /// Convert a JSON object into an [Activity] instance.
//   /// This enables type-safe reading of the API response.
//   factory InventoryItem.fromJson(Map<String, dynamic> json) => _$InventoryItemFromJson(json);
// }