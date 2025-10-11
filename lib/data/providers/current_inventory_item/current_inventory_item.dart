import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_generator/builder.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

part 'current_inventory_item.g.dart';

@riverpod
class CurrentInventoryItem extends _$CurrentInventoryItem {
  @override
  InventoryItemLocal build() {
    return InventoryItemLocal.empty();
  }

  void updateCurrentInventoryItem(InventoryItemLocal item) {
    state = item;
  }

  /*******
final name = SomeNotifierProvider.someModifier<MyNotifier, Result>(MyNotifier.new);
 
class MyNotifier extends SomeNotifier<Result> {
  @override
  Result build() {
    <your logic here>
  }
  <your methods here>
}
 */
  // Filter to hold current inventory item id
  // final currentInventoryItemProvider =
  //     NotifierProvider<InventoryItemLocal, String>(() {
  //       return CurrentInventoryNotifier();
  //     });

  // class CurrentInventoryNotifier extends Provider<InventoryItemLocal> {
  //   @override
  //   InventoryItemLocal build() {
  //     return InventoryItemLocal;
  //   }

  // }

  // final singleInventoryFilter = Provider<InventoryItemLocal>((ref) {
  //   final List<InventoryItemLocal> inventory = ref.watch(inventoryLocalProvider);
  //   // final id = ref.watch(currentInventoryItemProvider);

  //   return inventory.where((item) => item.id == id).single;
  // });
}
