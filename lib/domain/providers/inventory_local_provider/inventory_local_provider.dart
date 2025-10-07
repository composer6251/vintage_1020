import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/sqflite/local_db.dart';
import 'package:vintage_1020/utils/globals.dart' as globals;


part 'inventory_local_provider.g.dart';


final userEmail = FirebaseAuth.instance.currentUser?.email;

final ScaffoldMessengerState _scaffold = globals.scaffoldKey.currentState!;

@Riverpod(keepAlive: true)
class InventoryLocal extends _$InventoryLocal {
  @override
  List<InventoryItemLocal> build() {
    return [];
  }

  Future<List<InventoryItemLocal>> getUserInventory() async {
    List<InventoryItemLocal> inventory = await LocalDb()
        .getUserInventoryLocal();

    state = [...state, ...inventory];

    return inventory;
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
        item.itemDimensions,
      ),
    ];

    LocalDb().insertIntoInventoryItem(item);
  }

  List<InventoryItemLocal> getInventoryState() {
    return state;
  }

  Future<int> deleteUserInventoryByEmail() async {
    int numberOfDeletedItems = await LocalDb().deleteUserInventory();

    List<InventoryItemLocal> items = await LocalDb().getUserInventoryLocal();
    if (items.isEmpty) {
      state = [...items];
    }

    return numberOfDeletedItems;
  }
}
