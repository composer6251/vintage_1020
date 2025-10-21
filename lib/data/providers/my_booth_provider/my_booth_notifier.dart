// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:vintage_1020/data/local_db/my_booths_db.dart';
// import 'package:vintage_1020/data/providers/inventory_notifier.dart';
// import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
// import 'package:vintage_1020/data/local_db/local_db.dart';
// import 'package:vintage_1020/domain/my_booth/my_booth.dart';

// part 'my_booth_notifier.g.dart';

// @riverpod
// class MyBoothNotifier extends _$MyBoothNotifier {
  
//   @override
//   MyBooth? build() {

//     // setBoothInventory();
//     return stateOrNull;
//   }

//   Future<MyBooth> fetchUserBooth() async {

//     MyBooth currentUserBooth = await MyBoothsDb().fetchCurrentBoothsByEmail();

//     state = currentUserBooth;

//     return currentUserBooth;

//   }

//   Future<void> createBoothForUser(MyBooth boothToInsert) async {

//     await LocalDb().createBoothForUser(boothToInsert);

//   }

//   void setBoothInventory() {

//     List<InventoryItemLocal> allInventory = ref.watch(inventoryProvider);

//     List<InventoryItemLocal> boothInventory = allInventory.where((item) => item.isBoothItem).toList();
//     MyBooth
//     currentBooth.boothInventory = boothInventory;

//     state = currentBooth;
//   }
// }