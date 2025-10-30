// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

part 'current_booth_provider.g.dart';

@riverpod
class CurrentBoothNotifier extends _$CurrentBoothNotifier {
  @override
  MyBooth build() {
    print('current Booth provider build');
    return MyBooth.initial('', []);
  }

  void setCurrentBooth(MyBooth booth) {
    // List<InventoryItemLocal> inventory = ref.watch(inventoryLocalProvider);
    // booth.boothInventory = inventory
    //     .where((item) => item.boothName == booth.boothName)
    //     .toList();
    // print('setting currentBooth with inventorySize: ${inventory.length}');
    state = booth;
    ref.notifyListeners();
  }
}
