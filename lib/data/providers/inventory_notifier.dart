

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_filter_provider/inventory_filter_provider.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

part 'inventory_notifier.g.dart';

@riverpod 
class InventoryNotifier extends _$InventoryNotifier{

  @override 
  List<InventoryItemLocal> build() {
    List<InventoryItemLocal> inventory = ref.watch(inventoryLocalProvider);
    return inventory;
  }

  void setFilteredInventory(InventoryFilter currentFilter) {

    final currentItem = ref.watch(currentInventoryItemProvider);
    final inventory = ref.watch(inventoryLocalProvider);
    final currentFilter = ref.watch(filterProvider);

    List<InventoryItemLocal> filteredInventory = [];
    if(currentFilter == InventoryFilter.myBooth) { 
      filteredInventory = inventory.where((item) => item.isCurrentBoothItem == 1.0).toList();
      state = [...filteredInventory];
      return;
    }
    // if(currentFilter == InventoryFilter.listed) { 
    //   filteredInventory = inventory.where((item) => item.itemListingDate != null && item.itemSoldDate == null).toList();
    //   state = [...filteredInventory];
    //   return;
    // }
    if(currentFilter == InventoryFilter.backStock) { 
      filteredInventory = inventory.where((item) => item.itemSoldDate != null).toList();
      state = [...filteredInventory];
      return;
    }
    if(currentFilter == InventoryFilter.sold) { 
      filteredInventory = inventory.where((item) => item.itemDeleteDate != null).toList();
      state = [...filteredInventory];
      return;
    }
    if(currentFilter == InventoryFilter.furniture) { 
      filteredInventory = inventory.where((item) => item.itemCategory == 'Furniture').toList();
      state = [...filteredInventory];
      return;
    }
    if(currentFilter == InventoryFilter.current) { 
      filteredInventory = inventory.where((item) => item.id == currentItem.id).toList();
      state = [...filteredInventory];
      return;
    }
    // If no filters are applied, return all inventory
    state = inventory;
  }
}