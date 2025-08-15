import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/api_urls.dart';
import 'package:vintage_1020/data/api/b_t_api/b_t_api.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:http/http.dart' as http;

part 'inventory_provider.g.dart';

@Riverpod(keepAlive: true)
class InventoryNotifier extends _$InventoryNotifier {
  final _uuid = const Uuid();

  @override
  List<InventoryItem> build() {
    return [];
  }

  Future<InventoryItem?> fetchInventoryItemById(num id) async {
     
     final response = await http.get(Uri.https(apiBaseUrl, '/inventory/$id'));

     final json = jsonDecode(response.body);
  }

  void buildUserInventory(List<InventoryItem> items) {
    state = items;
  }

  Future<void> fetchUserInventory(String userEmail) async {
    final response = await http.get(
      Uri.http(apiBaseUrl, apiGetUserInventoryByEmail, {'userEmail': userEmail}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // HttpHeaders.authorizationHeader: token, // Replace with your actual CSRF token if needed
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      
      json.map((e) => addInventoryItem(InventoryItem.fromJson(e)));
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

  void addInventoryImage() {

  }

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
