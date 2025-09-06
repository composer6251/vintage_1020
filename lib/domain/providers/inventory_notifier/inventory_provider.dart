

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';


// final inventoryNotifier = AsyncNotifierProvider<List<InventoryItem>>(
//   (ref) => InventoryNotifier(),
// );

/// ASYNC PROVIDER CLASS FOR INVENTORY
/// USES CODE GENERATION
@riverpod
class AsyncInventoryNotifierProvider extends _$AsyncInventoryNotifierProvider {
  @override
  Future<List<InventoryItem>> build() async {
    return Future.value('foo');
  }

  // Add methods to mutate the state
}
