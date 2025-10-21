import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/local_db/my_booths_db.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

part 'my_booths_notifier.g.dart';

@riverpod
class MyBoothsNotifier extends _$MyBoothsNotifier {
  
  @override
  List<MyBooth> build() {
    
    return [];
  }

  Future<List<MyBooth>> fetchUserBooths() async {

    List<MyBooth> userBooths = await MyBoothsDb().fetchUserBoothsByEmail();

    state = userBooths;

    return userBooths;
  }

  Future<void> createBoothForUser(MyBooth boothToInsert) async {

    await LocalDb().createBoothForUser(boothToInsert);

  }

    Future<void> getCurrentBooth(String boothId) async {

      MyBooth currentBooth;
  }


  // void setBoothInventory() {
  //   List<InventoryItemLocal> allInventory = ref.watch(inventoryProvider);

  //   List<InventoryItemLocal> boothInventory = allInventory.where((item) => item.isBoothItem).toList();

  //   MyBooth currentBooth = state;

  //   currentBooth.boothInventory = boothInventory;

  //   state = currentBooth;
  // }
}