

// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

part 'item_purchase_cost.g.dart';

@riverpod
class InventoryPurchaseCost extends _$InventoryPurchaseCost{

  @override
  double build() {
    
    List<InventoryItemLocal> inventory = ref.watch(inventoryProvider);

    return setInventoryPurchaseCost();
  }

  double setInventoryPurchaseCost() {

    List<InventoryItemLocal> inventory = ref.watch(inventoryProvider);

    double cost = 0.0;

    for (InventoryItemLocal item in inventory) {

      cost += item.itemPurchasePrice as double;
    }
    return cost;
  }

}