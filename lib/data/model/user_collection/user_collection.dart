import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';

// tells riverpod these are part of the code for this file.
part 'user_collection.freezed.dart';
part 'user_collection.g.dart';

// _$InventoryItem is a mixin that allows InventoryItem to inherit properties from the generated class (part 'inventory_item_rp.freezed.dart')
@freezed
sealed class UserCollection with _$UserCollection {
  const factory UserCollection({ // Optional ID for the item
    required String username,
    required List<InventoryItem>? inventory,
    required DateTime timestamp
  }) = _UserCollection; // Freezed generates private implementation class

  /// Convert a JSON object into an [UserCollection] instance.
  /// This enables type-safe reading of the API response.
  factory UserCollection.fromJson(Map<String, dynamic> json, List<InventoryItem> items) =>
      _$UserCollectionFromJson(json);

      factory UserCollection.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      List<InventoryItem> items,
    ) {
      final data = snapshot.data();

      final Timestamp ts = snapshot.get('timestamp');
      print('inventory ${data?['inventory']}');

      return UserCollection(
        username: data?['user'],
        inventory: items,
        // inventory: data?['inventory'] is List ? List.from(data?['inventory']) : null,
        timestamp: ts.toDate(),
      );
  }
}
