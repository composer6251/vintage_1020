import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/constants/api_urls.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/repositories/inventory_repository.dart';

part 'inventory_repository_impl.g.dart';

@Riverpod(keepAlive: true)
InventoryRepository inventoryRepository(Ref ref) => InventoryRepositoryImpl();

class InventoryRepositoryImpl implements InventoryRepository {

  @override
  Future<List<InventoryItem>> getInventoryByUserEmail(
    String userEmail,
  ) async {
    try {
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
        final items = json.map((e) => InventoryItem.fromJson(e)).toList();
        // return AsyncValue.data(items.cast<InventoryItem>());
        return items;
      } else {
        return Future.error(Exception('Failed to retrieve inventory item'), StackTrace.current);
      }
    } catch (e, st) {
      return Future.error(e, st);
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
