import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:http/http.dart' as http;
import 'package:vintage_1020/data/repositories/inventory_repository.dart';
import 'package:vintage_1020/data/repositories/inventory_repository_impl.dart';

part "future_inventory_provider.g.dart";

final FirebaseAuth auth = FirebaseAuth.instance;
String? email = auth.currentUser?.email;

@riverpod
class FutureInventoryProvider extends _$FutureInventoryProvider {


  late final InventoryRepository inventoryRepository;
  List<InventoryItem> _items = [];
  String? userEmail = email;
  void build(){}
  // List<InventoryItem> get => _items;

  // @override
  // FutureOr<List<InventoryItem>> build() async {
    
  //   state = await AsyncValue.guard(() async {
  //     return inventoryRepository.getInventoryByUserEmail(email!);
  //   });
  // }

// @override
//   AsyncValue<List<InventoryItem>> build()  {

//         state =  AsyncValue.guard(()  {
//       return inventoryRepository.getInventoryByUserEmail(email!);
//     });

//     return state;
//   }



  // InventoryRepository inventoryRepository(Ref ref) => InventoryRepositoryImpl();
}
