import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/utils/globals.dart' as globals;
import 'dart:developer' as dev;

part 'inventory_provider.g.dart';

final userEmail = FirebaseAuth.instance.currentUser?.email;

@Riverpod(keepAlive: true)
class InventoryLocal extends _$InventoryLocal {
  @override
  List<InventoryItemLocal> build() {
    print('provider build');

    return state;
  }

  Future<List<InventoryItemLocal>> fetchInitialUserInventory() async {
    List<InventoryItemLocal> inventoryWithArchives = await LocalDb()
        .getUserInventoryLocal();
    print('Fetch from DB return ${inventoryWithArchives.length} items');

    List<InventoryItemLocal> inventory = [];
    try {
      inventory = inventoryWithArchives
          .where((item) => item.itemDeleteDate != null)
          .toList();
    } catch (ex) {
      dev.log(
        'Error caught deserializing DB fetchInitialInventoryLocal: ${ex.toString()}',
      );
    }
    print('fetching initial inventory with ${inventory.length} items');
    state = [...inventory];

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
        item.itemHeight,
        item.itemWidth,
        item.itemDepth,
        item.itemDeleteDate,
        item.isCurrentBoothItem,
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

  Future<int> deleteInventoryItem(String id) async {
    // Remove from state
    state = state.where((item) => item.id != id).toList();
    // Hard delete
    int numberOfDeletedItems = await LocalDb().softDeleteInventoryItem(id);

    return numberOfDeletedItems;
  }

  // void toggleInventoryStatus(num id) {
  //   state = [
  //     for (final item in state)
  //       if (item.id == id) item.copyWith(id: _uuid.v4()) else item,
  //   ];
  // }

  // void makeCurrentInventoryItem(num id) {
  //   state = [
  //     for (final item in state)
  //       if (item.id == id)
  //         item.copyWith(id: 0)
  //       // Assign a new ID to make it current
  //       else
  //         item,
  //   ];
  // }
}

enum InventoryFilter {
  all,
  myBooth,
  notListed,
  sold,
  furniture,
  archived,
  deleted,
}

// CREATE FILTER PROVIDER AND DEFAULT TO ALL
final filteredInventoryProvider = StateProvider((_) => InventoryFilter.myBooth);

final inventoryFilter = Provider<List<InventoryItemLocal>>((ref) {
  final List<InventoryItemLocal> inventory = ref.watch(inventoryLocalProvider);
  final filter = ref.watch(filteredInventoryProvider);

  switch (filter) {
    case InventoryFilter.myBooth:
      print('Filter BOOTH');
      return inventory
          .where(
            (item) => item.itemListingDate != null && item.itemSoldDate == null,
          )
          .toList();
    case InventoryFilter.notListed:
      print('Filter NOT LISTED');
      return inventory.where((item) => item.itemListingDate != null).toList();
    case InventoryFilter.sold:
      print('Filter SOLD');
      return inventory.where((item) => item.itemSoldDate != null).toList();
    case InventoryFilter.furniture:
      print('Filter FURNITURE');
      return inventory
          .where((item) => item.itemCategory == 'Furniture')
          .toList();
    // TODO: IMPLEMENT
    case InventoryFilter.archived:
      return inventory;
    // TODO: IMPLEMENT
    case InventoryFilter.deleted:
      print('Filter DELETED');
      return inventory.where((item) => item.itemSoldDate != null).toList();
    case InventoryFilter.all:
      return inventory;
  }
});
