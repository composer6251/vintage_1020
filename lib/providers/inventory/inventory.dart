
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/repositories/inventory_repository.dart';
import 'package:vintage_1020/data/repositories/inventory_repository_impl.dart';

part 'inventory.g.dart';

enum InventoryFilter {all, sold, notSold}

@riverpod
class InventoryNotifier extends _$InventoryNotifier {

  late final InventoryRepository inventoryRepository;
  InventoryFilter _inventoryFilter = InventoryFilter.all;
  List<InventoryItem> _items = [];
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  InventoryFilter get currentFilter => _inventoryFilter;

  @override
  List<InventoryItem> build() {
    inventoryRepository = ref.watch(inventoryRepository as ProviderListenable<InventoryRepository>);
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