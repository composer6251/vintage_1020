/****Imports/parts and commented out dataType are for use with @freezed which I haven't gotten to work */

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'inventory.freezed.dart';
// part 'inventory.g.dart';

// / The response of the `GET /api/activity` endpoint.
class Inventory {
  Inventory({
    required this.key,
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
  });

  /// Convert a JSON object into an [Activity] instance.
  /// This enables type-safe reading of the API response.
  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      key: json['key'] as String,
      activity: json['activity'] as String,
      type: json['type'] as String,
      participants: json['participants'] as int,
      price: json['price'] as double,
    );
  }

  final String key;
  final String activity;
  final String type;
  final int participants;
  final double price;
}

/// The response of the `GET /api/activity` endpoint.
///
/// It is defined using `freezed` and `json_serializable`.
// @freezed
// sealed class Inventory with _$Inventory {
//   factory Inventory({
//     required String key,
//     required String activity,
//     required String type,
//     required int participants,
//     required double price,
//   }) = _Inventory;

//   /// Convert a JSON object into an [Activity] instance.
//   /// This enables type-safe reading of the API response.
//   factory Inventory.fromJson(Map<String, dynamic> json) =>
//       _$InventoryFromJson(json);
// }
