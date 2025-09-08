import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/domain/repositories/firestore/firestore_repository.dart';

part 'firestore_provider.g.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

String? userEmail = firebaseAuth.currentUser?.email;

@Riverpod(keepAlive: true)
class FirestoreProvider extends _$FirestoreProvider {
  @override
  Future<void> build() async {
    print('Getting user inventory async provider');
    FirestoreProvider firestoreProvider = FirestoreProvider(),

    return [];
  }

  Future<void> fetchInventory() async {
    List<dynamic> results = await fetchInventoryByEmail();
  }
}
