

// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

part 'item_purchase_cost.g.dart';

@riverpod
class InventoryPurchaseCost extends _$InventoryPurchaseCost{

  // TODO: Create map of values to return or separate provider for returning booth value/cost
  @override
  double build() {
    
    return setInventoryPurchaseCost();
  }

  double setInventoryPurchaseCost() {

    List<InventoryItemLocal> inventory = ref.watch(inventoryProvider);

    double cost = 0.0;

    for (InventoryItemLocal item in inventory) {

      cost += item.itemPurchasePrice ?? 0.0;
    }
    return cost;
  }

}