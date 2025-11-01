// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

part 'current_booth_provider.g.dart';

@riverpod
class CurrentBoothNotifier extends _$CurrentBoothNotifier {
  @override
  MyBooth build() {
    return MyBooth.initial('', []);
  }

  void setCurrentBooth(MyBooth booth) {
    MyBooth boothWithInventory = setInventoryForBooth(booth);
    state = booth;
    ref.notifyListeners();
  }

  MyBooth setInventoryForBooth(MyBooth selectedBooth) {
    List<InventoryItemLocal> inventory = ref.read(inventoryLocalProvider);
    MyBooth booth = selectedBooth;
    List<InventoryItemLocal> boothInventoryItems =
        selectedBooth.boothInventory = inventory
            .where((item) => selectedBooth.boothInventoryIds.contains(item.id))
            .toList();

    booth.boothInventory = boothInventoryItems;
    ref.notifyListeners();

    return booth;
  }

  void setCurrentBoothById(String id) {
    final booths = ref.watch(myBoothsProvider);

    state = booths.singleWhere((booth) => booth.id == id);

    ref.notifyListeners();
  }
}
