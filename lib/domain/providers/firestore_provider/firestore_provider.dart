import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/model/user_collection/user_collection.dart';
import 'package:vintage_1020/domain/repositories/firestore/firestore_repository.dart';

part 'firestore_provider.g.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

String? userEmail = firebaseAuth.currentUser?.email;

UserCollection? userCollectionId;

@Riverpod(keepAlive: true)
class FirestoreProvider extends _$FirestoreProvider {
  @override
  List<InventoryItem> build() {
    print('Getting user inventory async provider');
    // FirestoreProvider firestoreProvider = FirestoreProvider();
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

  Future<void> getUserCollectionId() async {
    UserCollection results = await getUserInventoryIdByEmail();

    userCollectionId = results;
  }

  

    Future<void> addUserInventoryItem(InventoryItem item) async {
    var result = await addInventoryItemToUserCollection(item);
    state = [...state,       
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


  }

  List<InventoryItem> getInventoryState() {
    return state;
  }
}
