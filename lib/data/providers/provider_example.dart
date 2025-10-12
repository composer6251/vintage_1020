
// ### PROVIDERS QUICK REF:
// ✅ Provider: For simple immutable values
// ✅ FutureProvider: For async operations that return a single value
// ✅ StreamProvider: For reactive async data streams
// ✅ NotifierProvider: For mutable state management in response to user interaction
// ✅ AsyncNotifierProvider: For mutable state with async operations

// NotifierProvider
// 1. Create class that extends  Riverpod NotifierProvider
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

part 'provider_example.g.dart';

// 2. Add @riverpod annotation and Riverpod will generate the MOST APPROPRIATE PROVIDER AND ALLOW FOR STATE MUTATION
@riverpod
class ProviderExample extends _$ProviderExample{

  @override 
  List<InventoryItemLocal> build() {
    return [];
  }

  // Add mutation methods

  // Create enum filters

  // Create logic to filter by enum

//   1- Make a NotifierProvider that holds the current filter query.
// 2- Mutate that query provider at the onChanged of your text field.
// 3- Make another provider that watch both futureCameraListProvider and the query provider, and return a filtered list.
// 4- Use that filteredProvider at your screen.

/// GETTERS
  Future<List<InventoryItemLocal>> fetchInitialUserInventory() async {
    List<InventoryItemLocal> inventoryWithArchives = await LocalDb()
        .getUserInventoryLocal();
    print('Fetch from DB return ${inventoryWithArchives.length} items');

    state = [...inventoryWithArchives];

    return inventoryWithArchives;
  }

    List<InventoryItemLocal> getInventoryState() {
    return state;
  }

  InventoryItemLocal getCurrentInventoryItemById(String id) {
    return state.where((item) => item.id == id).single;
  }

  // ADDS
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
        item.isCurrentBoothItem ?? 1,
      ),
    ];

    LocalDb().insertIntoInventoryItem(item);
  }

  /// DELETE
  Future<int> deleteUserInventoryByEmail() async {
    int numberOfDeletedItems = await LocalDb().deleteUserInventory();

    List<InventoryItemLocal> items = await LocalDb().getUserInventoryLocal();
    if (items.isEmpty) {
      state = [...items];
    }

    return numberOfDeletedItems;
  }

  Future<int> deleteInventoryItem(String id) async {
    // Remove from state
    state = state.where((item) => item.id != id).toList();
    // Hard delete
    int numberOfDeletedItems = await LocalDb().softDeleteInventoryItem(id);

    return numberOfDeletedItems;
  }
}
