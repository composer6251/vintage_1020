import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/constants/enums.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

part 'inventory_counts_notifier.g.dart';

final userEmail = FirebaseAuth.instance.currentUser?.email;

@Riverpod(keepAlive: false)
class InventoryCountsNotifier extends _$InventoryCountsNotifier {
  @override
  Map<String, int> build() {
    ref.watch(inventoryLocalProvider);
    return {};
  }

  Future<void> setInventoryCounts() async {
    print('setting inventory counts');
    // Watch inventory
    List<InventoryItemLocal> inventory = ref.watch(inventoryLocalProvider);

    Map<String, int> inventoryCounts = {};

    inventoryCounts[InventoryFilter.all.name] = inventory.length;
    inventoryCounts[InventoryFilter.backStock.name] = inventory
        .where((item) => !item.isListed)
        .toList()
        .length;
    inventoryCounts[InventoryFilter.listed.name] = inventory
        .where((item) => item.isListed)
        .toList()
        .length;
    inventoryCounts[InventoryFilter.sold.name] = inventory
        .where((item) => item.isSold)
        .toList()
        .length;
  }
}
