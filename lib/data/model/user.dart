import 'package:freezed_annotation/freezed_annotation.dart';

// tells riverpod these are part of the code for this file.
part 'user.freezed.dart';
part 'user.g.dart';

// _$InventoryItem is a mixin that allows InventoryItem to inherit properties from the generated class (part 'inventory_item_rp.freezed.dart')
@freezed
sealed class User with _$User {
  const factory User({ // Optional ID for the item
    required String userEmail,
    String? userName,
    String? userInventoryId,
  }) = _User; // Freezed generates private implementation class
// Getter for itemId, defaults to 0 if id is null
  /// Convert a JSON object into an [User] instance.
  /// This enables type-safe reading of the API response.
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}
