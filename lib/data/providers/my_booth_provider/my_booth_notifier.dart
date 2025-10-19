import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

part 'my_booth_notifier.g.dart';

@riverpod
class MyBoothNotifier extends _$MyBoothNotifier {
  
  @override
  MyBooth build() {
    
    return state;
  }

  Future<MyBooth> fetchUserBooth() async {

    MyBooth currentUserBooth = await LocalDb().fetchCurrentBoothByEmail();

    state = currentUserBooth;

    return currentUserBooth;

  }

  Future<void> insertInitalUserBooth() async {

    await LocalDb().addBoothToMyBoothTable(MyBooth.empty());

  }
}