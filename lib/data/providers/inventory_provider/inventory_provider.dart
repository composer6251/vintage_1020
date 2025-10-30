import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/data/local_db/my_booths_db.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/local_db/inventory_db.dart';

part 'inventory_provider.g.dart';

final userEmail = FirebaseAuth.instance.currentUser?.email;

@Riverpod(keepAlive: false)
class InventoryLocal extends _$InventoryLocal {
  @override
  List<InventoryItemLocal> build() {
    return [];
  }

  Future<void> setInitialInventory() async {
    List<InventoryItemLocal> inventory;
    try {
      inventory = await fetchInitialUserInventory();
    } on Exception catch (e) {
      throw e;
    }

    if (ref.mounted) {
      state = inventory;
    }
  }

  Future<List<InventoryItemLocal>> fetchInitialUserInventory() async {
    List<InventoryItemLocal> inventoryWithArchives = await InventoryDb()
        .fetchUserInventoryFromDb();
    print('Fetch from DB return ${inventoryWithArchives.length} items');
    state = [...inventoryWithArchives];

    return inventoryWithArchives;
  }

  Future<void> addUserInventoryItemLocal(InventoryItemLocal item) async {
    state = [
      ...state,
      InventoryItemLocal.toLocalDb(
        item.id,
        userEmail,
        item.primaryImageUrl,
        item.itemDescription,
        item.itemImageUrls,
        item.itemCategory,
        item.itemPurchasePrice,
        item.itemListingPrice,
        item.itemSoldPrice,
        item.itemPurchaseDate,
        item.itemListingDate,
        item.itemSoldDate,
        item.itemHeight,
        item.itemWidth,
        item.itemDepth,
        item.itemDeleteDate,
        item.boothName,
      ),
    ];
    ref.notifyListeners();
    InventoryDb().insertIntoInventoryItem(item);
  }

  Future<void> quickAddInventoryItem(String itemImageUrl) async {
    InventoryItemLocal itemToSave = InventoryItemLocal.empty(Uuid().v6());

    itemToSave.userEmail = userEmail;
    itemToSave.itemPurchaseDate = DateTime.now();
    itemToSave.primaryImageUrl = itemImageUrl;
    itemToSave.itemImageUrls = [itemImageUrl];

    state = [...state, itemToSave];

    InventoryDb().insertIntoInventoryItem(itemToSave);
  }

  List<InventoryItemLocal> getInventoryState() {
    return state;
  }

  InventoryItemLocal getCurrentInventoryItemById(String id) {
    return state.where((item) => item.id == id).single;
  }

  void updateCurrentInventoryItemById(
    InventoryItemLocal newItem,
    InventoryItemLocal oldItem,
  ) {
    int indexOfItemToUpdate = state.indexOf(oldItem);
    if (indexOfItemToUpdate == -1) {
      print('Failed to find item to update in current state');
    }

    state.removeAt(indexOfItemToUpdate);
    state.insert(indexOfItemToUpdate, newItem);

    InventoryDb().updateInventoryItem(newItem);
  }

  Future<int> deleteUserInventoryByEmail() async {
    int numberOfDeletedItems = await InventoryDb().deleteUserInventory();

    List<InventoryItemLocal> items = await InventoryDb()
        .fetchUserInventoryFromDb();
    if (items.isEmpty) {
      state = [...items];
    }

    return numberOfDeletedItems;
  }

  Future<int> deleteInventoryItem(String id) async {
    // Remove from state
    state = state.where((item) => item.id != id).toList();

    int numberOfDeletedItems = await InventoryDb().softDeleteInventoryItem(id);

    return numberOfDeletedItems;
  }
}
