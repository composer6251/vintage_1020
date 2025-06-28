import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;
 
//Add a new document to a collection (with an auto-generated ID)
Future<void> saveUser(String username, String password) async {
  try {
    await firestore.collection('inventoryItem').add({
      'username': username,
      'password': password,
    });
    print('User added locally and syncing');
  } catch (e) {
     print('Error saving user: $e');
  }
}