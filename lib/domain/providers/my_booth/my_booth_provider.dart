import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/model/my_booth/my_booth.dart';
import 'package:vintage_1020/domain/sqflite/local_db.dart';
import 'package:vintage_1020/utils/globals.dart' as globals;


part 'my_booth_provider.g.dart';


final userEmail = FirebaseAuth.instance.currentUser?.email;

final ScaffoldMessengerState _scaffold = globals.scaffoldKey.currentState!;

@Riverpod(keepAlive: true)
class MyBoothProvider extends _$MyBoothProvider {
  
  @override
  MyBooth build() {
    return state;
  }

  Future<void> fetchCurrentBoothFromUserEmail() async {
    // TODO: Implement fetch from DB, Firestore
    List<InventoryItemLocal> currentBoothInventory = await LocalDb().getUserInventoryLocal();
    // TODO Sort currentImageUrls by flag indicating they are listed.
    List<InventoryItemLocal> listedInventory = currentBoothInventory.where((item) => item.itemListingDate != null && item.itemSoldDate == null).toList();

    MyBooth currentBooth = MyBooth(uuid.v6(), userEmail, [], listedInventory);
    state = currentBooth;
  }

  Future<void> createNewBooth(MyBooth item) async {
    state = 
      MyBooth(
        item.id,
        userEmail,
        item.currentBoothImageUrls,
        item.currentListedInventory
      );

  Future<void> addInventoryItemsToCurrentBooth(InventoryItemLocal item) async {

    MyBooth currentBoothState = state;
    List<InventoryItemLocal>? currentBoothInventory = currentBoothState.currentListedInventory;
    currentBoothInventory?.add(item);
    currentBoothState.currentListedInventory = currentBoothInventory;
    MyBooth updatedBoothState = currentBoothState;
    state = updatedBoothState
    ;

    // LocalDb().insertIntoInventoryItem(item);
  }

  MyBooth getCurrentBoothState() {
    return state;
  }

  // Future<int> deleteUserInventoryByEmail() async {
  //   int numberOfDeletedItems = await LocalDb().deleteUserInventory();

  //   List<InventoryItemLocal> items = await LocalDb().getUserInventoryLocal();
  //   if (items.isEmpty) {
  //     state = [...items];
  //   }

  //   return numberOfDeletedItems;
  // }
  }
}
