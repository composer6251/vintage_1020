import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/utils/snack_bar.dart';

part 'inventory_notifier.g.dart';

@riverpod
class InventoryNotifier extends _$InventoryNotifier {
  @override
  List<InventoryItemLocal> build() {
    // Watch current inventory filter. getFilteredInventory watches the inventory,
    final providerFilter = ref.watch(filterProvider);

    List<InventoryItemLocal> filteredInventory = getFilteredInventory(
      providerFilter,
    );

    return filteredInventory;
  }

  List<InventoryItemLocal> getFilteredInventory(InventoryFilter currentFilter) {
    final providerFilter = ref.watch(filterProvider);
    // final currentItem = ref.watch(currentInventoryItemProvider);
    final inventory = ref.watch(inventoryLocalProvider);

    List<InventoryItemLocal> filteredInventory = [];
    // Check listed inventory by flag and by listing date and sold date = null
    // If no filters are applied, return all inventory
    if (currentFilter == InventoryFilter.all) {
      return inventory;
    }
    if (currentFilter == InventoryFilter.listed) {
      return inventory.where((item) => item.isBoothItem).toList();
    }
    if (currentFilter == InventoryFilter.sold) {
      return inventory.where((item) => item.isSold).toList();
    }
    if (currentFilter == InventoryFilter.backStock) {
       return inventory.where((item) => !item.isListed && !item.isSold && !item.isDeleted).toList();
    }
    // TODO: CREATE LABEL FOR FURNITURE/TIMEPERIOD/STYLE/SEASON....etc
    if (currentFilter == InventoryFilter.furniture) {
      filteredInventory = inventory
          .where((item) => item.itemCategory == 'Furniture')
          .toList();
      // state = [...filteredInventory];
      return [...filteredInventory];
    }
    // if (currentFilter == InventoryFilter.current) {
    //   filteredInventory = inventory
    //       .where((item) => item.id == currentItem.id)
    //       .toList();
    //   // state = [...filteredInventory];
    //   return [...filteredInventory];
    // }
    return inventory;
  }

  void addItemToBooth(String itemId) {
    // Store current state before updating
    List<InventoryItemLocal> currentState = state;
    // Get item to update as booth item
    InventoryItemLocal itemToAddToBooth = state.firstWhere(
      (item) => item.id == itemId,
    );

    // If the item to add isn't found, show snack bar.
    if (itemToAddToBooth.id.isEmpty) {
      print('Error in addItemToBooth. Item id not found in state');
      // TODO: SHOW SNACK BAR TO USER IN EVENT OF ERROR
      return;
    }

    // Remove existing item
    state.removeWhere((item) => item.id == itemId);

    // Update item as booth item
    itemToAddToBooth.isCurrentBoothItem = 1.0;
    // Update inventory
    currentState.add(itemToAddToBooth);
    // Update state so user sees reflected change
    state = [...currentState];
    // Persist change
    LocalDb().addInventoryItemToCurrentBooth(itemId);
  }
}
