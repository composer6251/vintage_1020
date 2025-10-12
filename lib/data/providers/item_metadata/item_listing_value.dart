

// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

part 'item_listing_value.g.dart';

@riverpod
class InventoryListingValue extends _$InventoryListingValue{

  @override
  double build() {

    return setInventoryPurchaseCost();
  }

  double setInventoryPurchaseCost() {

    List<InventoryItemLocal> inventory = ref.watch(inventoryProvider);

    double cost = 0.0;

    for (InventoryItemLocal item in inventory) {

      cost += item.itemListingPrice as double;
    }

    return cost;
  }

}