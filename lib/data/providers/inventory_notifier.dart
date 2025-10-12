

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

    return [];
  }

  void setFilteredInventory() {

    final currentItem = ref.watch(currentInventoryItemProvider);
    final inventory = ref.watch(inventoryLocalProvider);
    final currentFilters = ref.watch(filterProvider);

    List<InventoryItemLocal> filteredInventory = [];
    if(currentFilters[InventoryFilter.myBooth]!) { 
      filteredInventory = inventory.where((item) => item.isCurrentBoothItem == 1.0).toList();
      state = [...state, ...filteredInventory];
    }
    if(currentFilters[InventoryFilter.listed]!) { 
      filteredInventory = inventory.where((item) => item.itemListingDate != null && item.itemSoldDate == null).toList();
      state = [...state, ...filteredInventory];
    }
    if(currentFilters[InventoryFilter.sold]!) { 
      filteredInventory = inventory.where((item) => item.itemSoldDate != null).toList();
      state = [...state, ...filteredInventory];
    }
    if(currentFilters[InventoryFilter.deleted]!) { 
      filteredInventory = inventory.where((item) => item.itemDeleteDate != null).toList();
      state = [...state, ...filteredInventory];
    }
    if(currentFilters[InventoryFilter.furniture]!) { 
      filteredInventory = inventory.where((item) => item.itemCategory == 'Furniture').toList();
      state = [...state, ...filteredInventory];
    }
    if(currentFilters[InventoryFilter.current]!) { 
      filteredInventory = inventory.where((item) => item.id == currentItem.id).toList();
      state = [...state, ...filteredInventory];
    }
    if(currentFilters[InventoryFilter.all]!) { 
      filteredInventory = inventory;
      state = inventory;
    }
  }
}