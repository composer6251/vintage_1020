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

  Future<InventoryItem?> fetchInventoryItemById(String id) async {
     
     final response = await http.get(Uri.https(apiBaseUrl, '/inventory/$id'));

     final json = jsonDecode(response.body);
  }

    Future<InventoryItem?> saveInventoryItem(InventoryItem item) async {
     
     final response = await http.post(
      Uri.parse(apiBaseUrl + addItemUrl),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    // body: jsonEncode(<String, InventoryItem>{'title': '${item.itemDescription}', item}),
    );

  }
  void addInventoryItem(InventoryItem item) {
    state = [
      ...state,
      InventoryItem(
        id: _uuid.v4(),
        itemImageUrls: item.itemImageUrls,
        itemDescription: item.itemDescription,
        itemPurchaseDate: item.itemPurchaseDate,
        itemPurchasePrice: item.itemPurchasePrice,
        itemCategory: item.itemCategory,
        itemListingDate: item.itemListingDate,
        itemListingPrice: item.itemListingPrice,
        itemSoldPrice: item.itemSoldPrice,
        defaultItemImageUrl: item.defaultItemImageUrl,
        itemSoldDate: item.itemSoldDate,
      ),
    ];
  }

  void addInventoryImage() {
    
  }

  void toggleInventoryStatus(String id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(id: _uuid.v4()) else item,
    ];
  }

  void makeCurrentInventoryItem(String id) {
    state = [
      for (final item in state)
        if (item.id == id)
          item.copyWith(id: _uuid.v4())
           // Assign a new ID to make it current
        else
          item,
    ];
  }

  void removeInventoryItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}
