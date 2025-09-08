import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/domain/repositories/inventory_repository.dart';

part 'inventory_repository.g.dart';


/// REPOSITORY CLASS FOR API/DB CALLS.
/// WATCHED BY INVENTORY_PROVIDER.dart
/// PROVIDERS SHOULD GENERALLY BE USED FOR READ OPERATIONS AND NOT WRITE OPERATIONS.

enum InventoryFilter { all, sold, notSold }

@riverpod
class InventoryProvider extends _$InventoryProvider {
  late final InventoryRepository inventoryRepository;
  InventoryFilter _inventoryFilter = InventoryFilter.all;
  List<InventoryItem> _items = [];
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  InventoryFilter get currentFilter => _inventoryFilter;

  @override
  List<InventoryItem> build() {
    inventoryRepository = ref.watch(
      inventoryRepository as ProviderListenable<InventoryRepository>,
    );
    return [];
  }

  List<InventoryItem> _getFilteredInventory() {
    switch (_inventoryFilter) {
      case InventoryFilter.all:
        return _items;
      case InventoryFilter.notSold:
        return _items.where((item) => item.itemSoldDate == null).toList();
      case InventoryFilter.sold:
        return _items.where((item) => item.itemSoldDate != null).toList();
    }
  }

  void addInventoryItem(InventoryItem item) {
    state = [
      ...state,
      InventoryItem(
        itemImageUrls: item.itemImageUrls,
        itemDescription: item.itemDescription,
        itemPurchaseDate: item.itemPurchaseDate,
        itemPurchasePrice: item.itemPurchasePrice,
        itemCategory: item.itemCategory,
        itemListingDate: item.itemListingDate,
        itemListingPrice: item.itemListingPrice,
        itemSoldPrice: item.itemSoldPrice,
        primaryImageUrl: item.primaryImageUrl,
        itemSoldDate: item.itemSoldDate,
      ),
    ];
  }

  void makeCurrentInventoryItem(num id) {
    state = [
      for (final item in state)
        if (item.id == id)
          item.copyWith(id: 0)
        // Assign a new ID to make it current
        else
          item,
    ];
  }

  void removeInventoryItem(num id) {
    state = state.where((item) => item.id != id).toList();
  }
}
