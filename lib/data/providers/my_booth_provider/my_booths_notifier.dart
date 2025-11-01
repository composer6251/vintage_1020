import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/local_db/my_booths_db.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

part 'my_booths_notifier.g.dart';

@riverpod
class MyBoothsNotifier extends _$MyBoothsNotifier {
  @override
  List<MyBooth> build() {
    print('myBoothProvider build');
    return [];
  }

  Future<void> fetchUserBooths() async {
    List<MyBooth> userBooths = await MyBoothsDb().fetchUserBoothsByEmail();

    if (ref.mounted) {
      List<MyBooth> boothsWithInventory = userBooths
          .map((booth) => setInventoryForBooth(booth))
          .toList();

      state = boothsWithInventory;

      ref
          .read(currentBoothProvider.notifier)
          .setCurrentBooth(boothsWithInventory.first);

      ref.notifyListeners();
    }
  }

  Future<void> createBoothForUser(MyBooth boothToInsert) async {
    state = [...state, boothToInsert];
    ref.notifyListeners();
    await MyBoothsDb().createBoothForUser(boothToInsert);
  }

  Future<void> updateBooth(MyBooth boothToUpdate) async {
    // TODO: check if booth being updated is current booth.
    // If so, need to notify listeners/update provider.

    // TODO: find a different way to update. According to id

    // TODO: remove the state.remove

    // List<MyBooth> currentBooths = state;

    // MyBooth currentBooth = ref.read(currentBoothProvider);
    MyBooth currentBoothState = state
        .where((booth) => booth.id == boothToUpdate.id)
        .first;

    // Get Index of booth to update to maintain order
    int indexOfItemToUpdate = state.indexOf(currentBoothState);
    if (indexOfItemToUpdate == -1) {
      print('Failed to find item to update in current state');
      return;
    }

    state.removeAt(indexOfItemToUpdate);
    state.insert(indexOfItemToUpdate, currentBoothState);
    ref.read(currentBoothProvider.notifier).setCurrentBooth(currentBoothState);
    ref.notifyListeners();

    MyBoothsDb().updateBooth(currentBoothState);
  }

  Future<void> removeItemFromBoothById(String itemId, String boothId) async {
    // Get boothFromState
    MyBooth currentBoothState = state
        .where((booth) => booth.id == boothId)
        .first;

    // Get Index of booth to update to maintain order
    int indexOfItemToUpdate = state.indexOf(currentBoothState);
    if (indexOfItemToUpdate == -1) {
      print('Failed to find item to update in current state');
      return;
    }
    List<String> boothCurrentItemIds = currentBoothState.boothInventoryIds;

    boothCurrentItemIds.add(itemId);

    currentBoothState.boothInventoryIds = boothCurrentItemIds;
    setInventoryForBooth(currentBoothState);

    state.removeAt(indexOfItemToUpdate);
    state.insert(indexOfItemToUpdate, currentBoothState);
    ref.notifyListeners();
    await MyBoothsDb().updateBooth(currentBoothState);
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

  Future<void> deleteUserBooths() async {
    state = [];
    ref.notifyListeners();
    MyBoothsDb().softDeleteBoothsByUserEmail();
  }

  // TODO: IMPLEMENT METHOD TO ADD IMAGE URL TO BOOTH IMAGEURLS
  Future<void> addBoothPhoto(String boothUrl, String boothId) async {
    // Get boothFromState
    MyBooth currentBoothState = state
        .where((booth) => booth.id == booth.id)
        .first;
    currentBoothState.currentBoothImageUrls.add(boothUrl);
    ref.notifyListeners();

    // // Get Index of booth to update to maintain order
    // int indexOfItemToUpdate = state.indexOf(currentBoothState);
    // if (indexOfItemToUpdate == -1) {
    //   print('Failed to find item to update in current state');
    //   return;
    // }
    // state.removeAt(indexOfItemToUpdate);
    // state.insert(indexOfItemToUpdate, booth);

    // await MyBoothsDb().updateBooth(booth);

    // print('booths state after insert: ${state.length}');
  }
}
