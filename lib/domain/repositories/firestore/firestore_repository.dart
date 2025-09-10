import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/model/user_collection/user_collection.dart';

///  Repository for ****FLUTTER APP DIRECT CRUD OPERATIONS****
///  Writing Data (Always to Local Cache First, Then Sync to Cloud)
const String itemInventoryCollection = 'itemInventory';
const String userCollection = 'userCollection';
const String userTest = 'user';
const String inventory = 'inventory';
const String inventoryTest = 'inventoryTest';
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

final String? userEmail = firebaseAuth.currentUser?.email;
final String? uid = firebaseAuth.currentUser?.uid;

final firestore = FirebaseFirestore.instance;

/***** MAPPERS *****/

/*** IF NO PATH IS SET FOR DOC(), ID IS AUTO-GENERATED */
/**** TAKES THE STATE OBJECT FROM THE PROVIDER AND UPDATES THE FIRESTORE COLLECTION */
final ref = firestore
    .collection(inventory)
    .doc()
    .withConverter(
      fromFirestore: InventoryItem.fromFirestore,
      toFirestore: (InventoryItem item, _) => toFirestore(item),
    );

final inventoryUpdater = firestore
    .collection(inventory)
    .doc()
    .withConverter(
      fromFirestore: InventoryItem.fromFirestore,
      toFirestore: (InventoryItem item, _) => toFirestore(item),
    );

updateCollectionWithNewDocument(InventoryItem item) {
  ref.set(item, SetOptions(merge: true));
}

// updateCollectionWithNewDocuments(List<InventoryItem> items) {
//   Map<String, dynamic> toUpdate = items.map((i) => toFirestore(i)) as Map<String, dynamic>;

//   ref.set(toUpdate);
// }

// ignore: slash_for_doc_comments
/*************
 ***        **
 *** 
 **** GETs ***
 ***       ***
 ***       ***
 *************/

Future<List<InventoryItem>> getUser() async {
  final snapshot = await firestore
      .collection(userCollection)
      .where('username', isEqualTo: userEmail)
      .get();

  print('Returned ${snapshot.size} documents in fetchInvetoryByEmail call');

  if (snapshot.docs.isNotEmpty) {
    List<InventoryItem> items = snapshot.docs
        .map((doc) => InventoryItem.fromJson(doc.data()))
        .toList();
    return items;
  } else {
    throw Exception('No inventory found for the given email.');
  }
}

Future<UserCollection> getUserInventoryIdByEmail() async {
  print('Fetching firestore inventory with username: $userEmail');
  final snapshot = await firestore
      .collection(userCollection)
      .where('username', isEqualTo: userEmail)
      .get();
  print(
    'Returned ${snapshot.size} documents from USERCOLLECTION in getUserInventoryIdByEmail call',
  );
  if (snapshot.docs.isNotEmpty) {
    print(
      'snapshot.docs for userCollection: ${snapshot.docs.first.data().entries}',
    );

    UserCollection userCollection = UserCollection.fromJson(
      snapshot.docs.first.data(),
    );
    return userCollection;
  } else {
    throw Exception('No inventory found for the given email.');
  }
}

Future<List<InventoryItem>> fetchAllInventory() async {
  final snapshot = await firestore.collection(itemInventoryCollection).get();
  print('Returned ${snapshot.docs.length} documents in fetchAllInventory call');
  if (snapshot.docs.isNotEmpty) {
    List<InventoryItem> items = snapshot.docs
        .map((doc) => InventoryItem.fromJson(doc.data()))
        .toList();
    return items;
  } else {
    throw Exception('No inventory found for the given email.');
  }
}

Future<List<InventoryItem>> fetchInventoryByEmail() async {
  print('Fetching firestore inventory with username: $userEmail');
  final snapshot = await firestore
      .collection(inventoryTest)
      .where('username', isEqualTo: userEmail)
      .get();
  print('Returned ${snapshot.size} documents in fetchInvetoryByEmail call');
  if (snapshot.docs.isNotEmpty) {
    List<InventoryItem> items = snapshot.docs
        .map((doc) => InventoryItem.fromJson(doc.data()))
        .toList();
    return items;
  } else {
    throw Exception('No inventory found for the given email.');
  }
}

Future<List<InventoryItem>> getDocumentById() async {
  final DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore.collection(inventoryTest).doc(userEmail).get();
  
  var data = InventoryItem.fromJson(snapshot.get('inventory'));
   //InventoryItem.fromJson(i.data()!)).toList();

  return List.empty();
}

Future<List<InventoryItem>> fetchInventoryByUserInventoryId() async {
  print('Fetching firestore inventory with username: $userEmail');
  final snapshot = await firestore
      .collection(itemInventoryCollection)
      .where('username', isEqualTo: userEmail)
      .get();
  print('Returned ${snapshot.size} documents in fetchInvetoryByEmail call');
  if (snapshot.docs.isNotEmpty) {
    List<InventoryItem> items = snapshot.docs
        .map((doc) => InventoryItem.fromJson(doc.data()))
        .toList();
    return items;
  } else {
    throw Exception('No inventory found for the given email.');
  }
}

// ignore: slash_for_doc_comments
/***********
 *         *
 *         *
 ***********
 *  POSTs. 
 * 
 * 
 */

// Create user with Map<User>
Future<void> createUser() async {
  try {
    await firestore.collection(userTest).doc(uid).set({
      'documentId': uid,
      'username': userEmail,
    }, SetOptions(merge: true));
  } catch (ex) {
    throw Exception('Error creating user: $ex');
  }
}

Future<void> createUserInventoryMap(List<InventoryItem> items) async {
  print('Updating user and inventory with ${items.length} items');

  List<Map<String, dynamic>> itemsMap = items
      .map((i) => toFirestore(i))
      .toList();

  await firestore.collection(inventoryTest).doc(userEmail).set({
    'user': userEmail,
    'inventory': itemsMap,
    'timestamp': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}

Future<void> updateUserAndInventory(List<InventoryItem> items) async {
  print('Updating user and inventory with ${inventory.length} items');

  var user = UserCollection(username: userEmail!, inventory: items);

  await firestore.collection(inventory).doc(uid).set({
    'user': user,
  }, SetOptions(merge: true));
}

Future<void> updateUserCollectionAndInventory(
  List<InventoryItem> inventory,
) async {
  print('Updating user and inventory with ${inventory.length} items');

  var user = UserCollection(username: userEmail!, inventory: inventory);
  await firestore.collection(userCollection).doc(uid).set({
    'user': user,
  }, SetOptions(merge: true));
}

//Add a new document to a collection (with an auto-generated ID)
Future<void> addInventoryItem(InventoryItem item) async {
  try {
    await firestore.collection(itemInventoryCollection).add({
      'itemImageUrls': item.itemImageUrls,
      'itemDescription': item.itemDescription,
      'itemPurchaseDate': item.itemPurchaseDate,
      'itemPurchasePrice': item.itemPurchasePrice,
      'itemListingDate': item.itemListingDate,
      'itemListingPrice': item.itemListingPrice,
      'itemSoldPrice': item.itemSoldPrice,
      'itemCategory': item.itemCategory,
      'itemSoldDate': item.itemSoldDate,
      'primaryImageUrl': item.primaryImageUrl,
    });
    print('InventoryItem added locally and syncing');
  } catch (e) {
    print('Error updating task: $e');
  }
}

Future<void> addInventoryItemToUserCollection(InventoryItem item) async {
  try {
    await firestore
        .collection(itemInventoryCollection)
        .add({
          'itemImageUrls': item.itemImageUrls,
          'itemDescription': item.itemDescription,
          'itemPurchaseDate': item.itemPurchaseDate,
          'itemPurchasePrice': item.itemPurchasePrice,
          'itemListingDate': item.itemListingDate,
          'itemListingPrice': item.itemListingPrice,
          'itemSoldPrice': item.itemSoldPrice,
          'itemCategory': item.itemCategory,
          'itemSoldDate': item.itemSoldDate,
          'primaryImageUrl': item.primaryImageUrl,
        })
        .then(
          (DocumentReference doc) =>
              print('InventoryItem saved with ID: ${doc.id}'),
        );
  } catch (e) {
    print('Error updating task: $e');
  }
}

/*** 
 * 
 * 
 * 
 * PRIVATE 
 * 
 * 
 * 
 * ****/

UserCollection buildUserCollection(List<InventoryItem> inventory) {
  if (userEmail == null || uid == null) {
    throw Exception(
      'Cannot build userCollection object without userEmail and uid',
    );
  }
  return UserCollection(username: userEmail!, inventory: inventory);
}
