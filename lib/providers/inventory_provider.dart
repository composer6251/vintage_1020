import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';

part 'inventory_provider.g.dart';

@Riverpod(keepAlive: true)
class InventoryNotifier extends _$InventoryNotifier {
  final _uuid = const Uuid();

  @override
  List<InventoryItem> build() {
    return [];
  }

  void addInventoryItem(InventoryItem item) {
    state = [
      ...state,
      InventoryItem(
        id: _uuid.v4(),
        itemImageUrls: item.itemImageUrls,
        itemDescription: item.itemDescription,
        itemPurchaseDate: item.itemPurchaseDate,
        itemPurchasePrice: item.itemPurchasePrice,
        itemCategory: item.itemCategory,
      ),
    ]; 
  }

  // void toggleInventoryStatus(String id) {
  //   state = [
  //     for (final item in state)
  //       if (item.id == id) {
  //         item.copyWith(id)
  //         }
  //         else {item},
  //   ];
  // }

  void removeInventoryItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}
