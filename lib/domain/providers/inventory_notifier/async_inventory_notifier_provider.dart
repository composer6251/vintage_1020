

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/domain/api/b_t_api/b_t_api.dart';

part 'async_inventory_notifier_provider.g.dart';

// final inventoryNotifier = AsyncNotifierProvider<List<InventoryItem>>(
//   (ref) => InventoryNotifier(),
// );

/// ASYNC PROVIDER CLASS FOR INVENTORY
/// USES CODE GENERATION




final userEmail = FirebaseAuth.instance.currentUser?.email;

@riverpod
class AsyncInventoryNotifierProvider extends _$AsyncInventoryNotifierProvider {
  @override
  Future<List<InventoryItem>> build() async {
    return getInventoryByUserEmail(userEmail!);
  }

  // Add methods to mutate the state
}
