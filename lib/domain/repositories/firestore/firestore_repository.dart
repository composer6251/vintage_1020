
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/model/user_collection/user_collection.dart';

///  Repository for ****FLUTTER APP DIRECT CRUD OPERATIONS****
///  Writing Data (Always to Local Cache First, Then Sync to Cloud)
const String itemInventoryCollection = 'itemInventory';
const String userCollection = 'userCollection';
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

final String? userEmail = firebaseAuth.currentUser?.email;
final String? uid = firebaseAuth.currentUser?.uid;

final firestore = FirebaseFirestore.instance;

// Create user with Map<User>
Future<void> createUser() async {
  try {
    final snapshot = await firestore
      .collection(userCollection)
      .doc(uid)
      .set({
        'documentId': uid,
        'username': userEmail,
      },
        SetOptions(merge: true)
      );
  } catch (ex) {
      throw Exception('Error creating user: $ex');
  }
}

UserCollection buildUserCollection(List<InventoryItem> inventory) {
  if(userEmail == null || uid == null) {
    throw Exception('Cannot build userCollection object without userEmail and uid');
  }
  return UserCollection(username: userEmail!, inventoryId: uid!, inventory: inventory);
}

Future<void> updateUserAndInventory(List<InventoryItem> inventory) async {
  print('Updating user and inventory with ${inventory.length} items');
  // UserCollection user = buildUserCollection(inventory);

  var user = UserCollection(username: userEmail!, inventoryId: uid!, inventory: inventory);
  await firestore
    .collection(userCollection)
    .doc(uid)
    .set({
      'user': user},
      SetOptions(merge: true)
    );
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
      .collection(itemInventoryCollection)
      .where('username', isEqualTo: 'test@test.com')
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

Future<List<InventoryItem>> fetchInventoryByUserInventoryId() async {
  print('Fetching firestore inventory with username: $userEmail');
  final snapshot = await firestore
      .collection(itemInventoryCollection)
      .where('username', isEqualTo: 'test@test.com')
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

// Set/Overwrite a document (you specify the ID)
Future<void> updateTaskById(num itemId, String newTitle) async {
  try {
    await firestore.collection('tasks').doc(itemId.toString()).set({
      'title': newTitle,
      'description': 'Updated description',
      'completed': false, // This will overwrite other fields if not careful
    });
    print('Task $itemId updated successfully (locally and syncing)');
  } catch (e) {
    print('Error updating task: $e');
  }
}

// Update specific fields in a document (non-destructive)
Future<void> updateInventoryItemById(String taskId) async {
  try {
    await firestore.collection('tasks').doc(taskId).update({
      'completed': true,
      'completedAt': FieldValue.serverTimestamp(),
    });
    print('Task $taskId marked completed (locally and syncing)');
  } catch (e) {
    print('Error marking task completed: $e');
  }
}
