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

    return [];
  }

  Future<List<InventoryItemLocal>> fetchInitialUserInventory() async {
    List<InventoryItemLocal> inventoryWithArchives = await LocalDb()
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
        item.isCurrentBoothItem,
      ),
    ];

    LocalDb().insertIntoInventoryItem(item);
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

    LocalDb().updateInventoryItem(newItem);
    // state = [
    //   ...state,
    //   for (final itemToUpdate in state)
    //     if (itemToUpdate.id == newItem.id) newItem,
    // ];
  }

  Future<int> deleteUserInventoryByEmail() async {
    int numberOfDeletedItems = await LocalDb().deleteUserInventory();

    List<InventoryItemLocal> items = await LocalDb().fetchUserInventoryFromDb();
    if (items.isEmpty) {
      state = [...items];
    }

    return numberOfDeletedItems;
  }

  Future<int> deleteInventoryItem(String id) async {
    // Remove from state
    state = state.where((item) => item.id != id).toList();

    int numberOfDeletedItems = await LocalDb().softDeleteInventoryItem(id);

    return numberOfDeletedItems;
  }
}
