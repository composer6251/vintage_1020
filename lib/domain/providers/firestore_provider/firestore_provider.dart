import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/model/user_collection/user_collection.dart';
import 'package:vintage_1020/domain/repositories/firestore/firestore_repository.dart';

part 'firestore_provider.g.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

final String? userEmail = firebaseAuth.currentUser?.email;
String? test = firebaseAuth.currentUser?.uid;

UserCollection? userCollectionId;

@Riverpod(keepAlive: true)
class FirestoreProvider extends _$FirestoreProvider {
  @override
  List<InventoryItem> build() {
    print('Getting user inventory async provider');
    return [];
  }

  Future<List<InventoryItem>> getInventoryByDocumentId() async {
    try {
      final inventory = await getDocumentById();
      state = inventory;
    } catch (ex) {
      throw Exception('Error getting document by id: $userEmail with exception $ex');
    }
    return state;
  }

  // collection.set w/merge = true. *CREATES USER IF DOESN'T EXIST, OTHERWISE IT MERGES NEW DATA ONLY */
  void updateUser() async {
    await updateUserAndInventory(state);
  }

  Future<void> updateInventory() async {
    createUserInventoryMap(state);
  }

  Future<void> fetchInventoryByUsername() async {
    List<InventoryItem> results = await fetchInventoryByEmail();
    state = results;
  }

  Future<void> fetchAllInventoryTest() async {
    List<InventoryItem> results = await fetchAllInventory();
    state = results;
  }

  Future<void> updateUserInventory() async {
    await updateUserAndInventory(state);
  }

  Future<void> getUserCollectionId() async {
    UserCollection results = await getUserInventoryIdByEmail();
    print('User Uuid: $test');
    userCollectionId = results;
  }

  Future<void> addUserInventoryItem(InventoryItem item) async {
    state = [
      ...state,
      InventoryItem(
        itemImageUrls: item.itemImageUrls,
        itemDescription: item.itemDescription,
        itemPurchaseDate: item.itemPurchaseDate,
        itemPurchasePrice: item.itemPurchasePrice,
        itemCategory: item.itemCategory,
        itemListingDate: item.itemListingDate,
        itemListingPrice: item.itemListingPrice,
        itemSoldPrice: item.itemSoldPrice,
        primaryImageUrl: item.primaryImageUrl,
        itemSoldDate: item.itemSoldDate,
      ),
    ];

    updateInventory();
  }

  List<InventoryItem> getInventoryState() {
    return state;
  }
}
