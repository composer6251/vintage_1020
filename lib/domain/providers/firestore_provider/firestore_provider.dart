import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/domain/repositories/firestore/firestore_repository.dart';

part 'firestore_provider.g.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

String? userEmail = firebaseAuth.currentUser?.email;

@Riverpod(keepAlive: true)
class FirestoreProvider extends _$FirestoreProvider {
  @override
  List<InventoryItem> build() {
    print('Getting user inventory async provider');
    FirestoreProvider firestoreProvider = FirestoreProvider();
    return [];
  }

  Future<void> fetchInventoryByUsername() async {
    List<InventoryItem> results = await fetchInventoryByEmail();
    state = results;
  }

    Future<void> fetchAllInventoryTest() async {
    List<InventoryItem> results = await fetchAllInventory();
    state = results;
  }
}
