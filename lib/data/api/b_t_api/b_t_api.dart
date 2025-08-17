import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vintage_1020/constants/api_urls.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';

Future<InventoryItem?> saveInventoryItem(InventoryItem item) async {
  // final String token = Uuid().v4();

  final response = await http.post(
    Uri.http(apiBaseUrl, addItemUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // HttpHeaders.authorizationHeader: token, // Replace with your actual CSRF token if needed
    },
    body: jsonEncode(item.toJson()),
  );
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return InventoryItem.fromJson(json);
  } else {
    throw Exception('Failed to add inventory item');
  }
}

Future<InventoryItem?> getInventoryItemById(num id) async {
  // final String token = Uuid().v4();

  final response = await http.get(
    Uri.http(apiBaseUrl, apiGetItemById, {'itemId': id.toString()}),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // HttpHeaders.authorizationHeader: token, // Replace with your actual CSRF token if needed
    },
  );
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return InventoryItem.fromJson(json);
  } else {
    throw Exception('Failed to add inventory item');
  }
}

Future<List<InventoryItem?>?> getInventoryByUserEmail(String userEmail) async {

  final response = await http.get(
    Uri.http(apiBaseUrl, apiGetUserInventoryByEmail, {'userEmail': userEmail}),
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