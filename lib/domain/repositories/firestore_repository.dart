import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';


///  Repository for ****FLUTTER APP DIRECT CRUD OPERATIONS****
///  Writing Data (Always to Local Cache First, Then Sync to Cloud)
///

final firestore = FirebaseFirestore.instance;


// Future<List<InventoryItem>> retrieveInventory(String email) async {
//
//     await firestore.collection('inventoryItem').where('inventory', isEqualTo: true).get().then(
//           (querySnapshot) {
//         print("Successfully completed");
//         for (var docSnapshot in querySnapshot.docs) {
//           print('${docSnapshot.id} => ${docSnapshot.data()}');
//         }
//       },
//       onError: (e) => print("Error completing: $e"),
//     );
//
//     return
//
//   }


 
//Add a new document to a collection (with an auto-generated ID)
Future<void> addInventoryItem(InventoryItem item) async {
  try {
    await firestore.collection('inventoryItem').add({
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

Future<void> a(InventoryItem item) async {
  try {
    await firestore.collection('inventoryItem').add({
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

// Example usage:
// await addTask('Buy groceries', 'Milk, eggs, bread');
// await markTaskCompleted('some_task_id');
