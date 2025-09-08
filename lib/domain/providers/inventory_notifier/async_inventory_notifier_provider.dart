

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/constants/api_urls.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/domain/api/b_t_api/b_t_api.dart';
import 'package:vintage_1020/domain/repositories/inventory_repository.dart';

part 'async_inventory_notifier_provider.g.dart';

/// ASYNC PROVIDER CLASS FOR INVENTORY
/// USES CODE GENERATION

final userEmail = FirebaseAuth.instance.currentUser?.email;

@Riverpod(keepAlive: true)
class AsyncInventoryNotifierProvider extends _$AsyncInventoryNotifierProvider {
  late final InventoryRepository inventoryRepository;
  List<InventoryItem> items = [];

  /****BUILD IS MEANT FOR LINKING UP WITH REPOSITORY AND INITIALIZING STAT */
  @override
  Future<List<InventoryItem>> build() async {
    /*****INITIALIZE STATE */
    print('Getting user inventory async provider');
    inventoryRepository = ref.watch(
      inventoryRepository as ProviderListenable<InventoryRepository>,
    );
    return [];
  }

  Future<void> getInventory() async {
    final response = await http.get(
      Uri.http(apiBaseUrl, apiGetUserInventoryByEmail, {'userEmail': userEmail}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // HttpHeaders.authorizationHeader: token, // Replace with your actual CSRF token if needed
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final items = json.map((e) => InventoryItem.fromJson(e)).toList();

      state = AsyncValue.data(items);
    } else {
      state = AsyncValue.error(Exception('Failed to retrieve inventory item'), StackTrace.current);
    }
  }

    void makeCurrentInventoryItem(num id) {
      final currentItems = state.value ?? [];
      final updatedItems = [
        for (final item in currentItems)
          if (item.id == id)
            item.copyWith(id: 0)
          // Assign a new ID to make it current
          else
            item,
      ];
      state = AsyncValue.data(updatedItems);
  }
}
