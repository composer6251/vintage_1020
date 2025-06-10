import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:namer_app/data/model/inventory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Necessary for code-generation to work
// part 'inventory_provider.g.dart';

/***
 * Provider class for fetching inventory items and passing to consumers of <inventoryProvider>
 */
final inventoryProvider = FutureProvider.autoDispose((ref) async {
  // Using package:http, we fetch a random activity from the Bored API.
  final response = await http.get(Uri.https('boredapi.com', '/api/activity'));
  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  // Finally, we convert the Map into an Activity instance.
  return Inventory.fromJson(json);
});
/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
// @riverpod
// Future<Inventory> inventoryItem(Ref ref) async {
//   // Using package:http, we fetch a random activity from the Bored API.
//   final response = await http.get(Uri.https('boredapi.com', '/api/activity'));
//   // Using dart:convert, we then decode the JSON payload into a Map data structure.
//   final json = jsonDecode(response.body) as Map<String, dynamic>;
//   // Finally, we convert the Map into an Activity instance.
//   return Inventory.fromJson(json);
// }

// @riverpod
// Future<List<InventoryItem>> inventory(Ref ref) async {
//   // Using package:http, we fetch a random activity from the Bored API.
//   final response = await http.get(Uri.https('boredapi.com', '/api/activity'));
//   // Using dart:convert, we then decode the JSON payload into a Map data structure.
//   final json = jsonDecode(response.body) as List<dynamic>;
//   // Finally, we convert the Map into an Activity instance.
//   if (json.isNotEmpty) {
//     return List.empty();
//   }

//   return List<InventoryItem>.from(json);
// }
