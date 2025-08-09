import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/api_urls.dart';
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
