import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vintage_1020/constants/api_urls.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
   
  Future<InventoryItem?> saveInventoryItem(InventoryItem item) async {
     
     final response = await http.post(
      Uri.parse(apiBaseUrl + addItemUrl),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    // body: jsonEncode(<String, InventoryItem>{'title': '${item.itemDescription}', item}),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return InventoryItem.fromJson(json);
    } else {
      throw Exception('Failed to add inventory item');
    }

  }