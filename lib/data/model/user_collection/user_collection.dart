import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vintage_1020/constants/inventory_categories.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';

// tells riverpod these are part of the code for this file.
part 'user_collection.freezed.dart';
part 'user_collection.g.dart';

// _$InventoryItem is a mixin that allows InventoryItem to inherit properties from the generated class (part 'inventory_item_rp.freezed.dart')
@freezed
sealed class UserCollection with _$UserCollection {
  const factory UserCollection({ // Optional ID for the item
    required String username,
    // required String inventoryId,
    required Map<String, InventoryItem> inventory,
    required DateTime timestamp
  }) = _UserCollection; // Freezed generates private implementation class
  // Getter for itemId, defaults to 0 if id is null
  /// Convert a JSON object into an [UserCollection] instance.
  /// This enables type-safe reading of the API response.
  factory UserCollection.fromJson(Map<String, dynamic> json) =>
      _$UserCollectionFromJson(json);

      factory UserCollection.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
    ) {
      final data = snapshot.data();
      final Timestamp ts = snapshot.get('timestamp');
      print('timestamp $ts');
      return UserCollection(
        username: data?['user'],
        inventory: data?['inventory'],
        timestamp: ts.toDate(),
      );
  }
}
