

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/sqflite/local_db.dart';

part 'inventory_local_provider.g.dart';


final userEmail = FirebaseAuth.instance.currentUser?.email;

@Riverpod(keepAlive: true)
class InventoryLocal extends _$InventoryLocal{

  @override 
  List<InventoryItemLocal> build() {
    return [];
  }

  Future<List<Set<InventoryItemLocal>>> getUserInventory() async {
    List<Set<InventoryItemLocal>> inventory = await LocalDb().getUserInventoryLocal();

    return inventory;
  }

    Future<void> addUserInventoryItemLocal(InventoryItemLocal item) async {
    state = [
      ...state,
      InventoryItemLocal.toLocalDb(
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
        item.itemDimensions
      ),
    ];

    LocalDb().insertIntoInventoryItem(item);
  }

  List<InventoryItemLocal> getInventoryState() {
    return state;
  }
}