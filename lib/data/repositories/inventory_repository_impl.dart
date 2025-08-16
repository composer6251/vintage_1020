import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/constants/api_urls.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:vintage_1020/data/repositories/inventory_repository.dart';

@Riverpod(keepAlive: true)
InventoryRepository inventoryRepository(Ref ref) => InventoryRepositoryImpl();

class InventoryRepositoryImpl implements InventoryRepository {

  @override
  Future<List<InventoryItem>> getInventoryByUserEmail(
    String userEmail,
  ) async {
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

    Future<void> saveInventoryItem(InventoryItem item) async {

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
    } else {
      throw Exception('Failed to add inventory item');
    }
  }
  
  @override
  Future<void> addInventoryItem(InventoryItem item) async {
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
      } else {
        throw Exception('Failed to add inventory item');
      }
  }
  
  @override
  Future<void> deleteInventoryItem(num itemId) async {
       final response = await http.post(
      Uri.http(apiBaseUrl, addItemUrl, {'itemId': itemId.toString()}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // HttpHeaders.authorizationHeader: token, // Replace with your actual CSRF token if needed
      },
      // body: jsonEncode(item.toJson()),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
      } else {
        throw Exception('Failed to add inventory item');
      }
  }

  @override
  Future<void> updateInventoryItem(InventoryItem item) async {
    final response = await http.post(
      Uri.http(apiBaseUrl, updateItemUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // HttpHeaders.authorizationHeader: token, // Replace with your actual CSRF token if needed
      },
      body: jsonEncode(item.toJson()),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
      } else {
        throw Exception('Failed to add inventory item');
      }
  }
}
