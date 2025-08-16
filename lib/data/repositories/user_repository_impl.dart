import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/repositories/user_repository.dart';

final firestore = FirebaseFirestore.instance;

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) => UserRepositoryImpl();

class UserRepositoryImpl implements UserRepository {

@override
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
}
//Add a new document to a collection (with an auto-generated ID)
