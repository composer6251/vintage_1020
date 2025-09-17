import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/api_urls.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:http/http.dart' as http;
import 'package:vintage_1020/domain/repositories/inventory_repository.dart';

part 'inventory_provider.g.dart';

enum InventoryFilter { all, sold, notSold }

final userEmail = FirebaseAuth.instance.currentUser?.email;


@riverpod
class InventoryNotifier extends _$InventoryNotifier {
  final _uuid = const Uuid();
  late final InventoryRepository inventoryRepository;
  InventoryFilter _inventoryFilter = InventoryFilter.all;
  List<InventoryItem> _items = [];
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  InventoryFilter get currentFilter => _inventoryFilter;

  @override
  List<InventoryItem> build() {
    inventoryRepository = ref.watch(
      inventoryRepository as ProviderListenable<InventoryRepository>,
    );
    return [];
  }

  List<InventoryItem> _getFilteredInventory() {
    switch (_inventoryFilter) {
      case InventoryFilter.all:
        return _items;
      case InventoryFilter.notSold:
        return _items.where((item) => item.itemSoldDate == null).toList();
      case InventoryFilter.sold:
        return _items.where((item) => item.itemSoldDate != null).toList();
    }
  }

  // Refreshes the inventory list from the repository
  // Future<void> refresh() async {
  //   // Keep previous state(data or error) while loading
  //   state = const AsyncLoading<List<InventoryItem>>().copyWithPrevious(state);

  //   state = await AsyncValue.guard(() async {
  //     _items = await inventoryRepository.getInventoryByUserEmail();
  //     return _getFilteredTodos();
  //   });
  // }

  Future<InventoryItem?> fetchInventoryItemById(num id) async {
    final response = await http.get(Uri.https(apiBaseUrl, '/inventory/$id'));

    final json = jsonDecode(response.body);
    return null;
  }

  void buildUserInventory(List<InventoryItem> items) {
    state = items;
  }

  Future<List<InventoryItem>> fetchUserInventory(String userEmail) async {
    final response = await http.get(
      Uri.http(apiBaseUrl, apiGetUserInventoryByEmail, {
        'userEmail': userEmail,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // HttpHeaders.authorizationHeader: token, // Replace with your actual CSRF token if needed
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;

      return json.map((e) => InventoryItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to retrieve inventory item');
    }
  }

  void addInventoryItem(InventoryItem item) {
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
  }

  void addInventoryImage() {}

  // void toggleInventoryStatus(num id) {
  //   state = [
  //     for (final item in state)
  //       if (item.id == id) item.copyWith(id: _uuid.v4()) else item,
  //   ];
  // }

  void makeCurrentInventoryItem(num id) {
    state = [
      for (final item in state)
        if (item.id == id)
          item.copyWith(id: 0)
        // Assign a new ID to make it current
        else
          item,
    ];
  }

  void removeInventoryItem(num id) {
    state = state.where((item) => item.id != id).toList();
  }
}
