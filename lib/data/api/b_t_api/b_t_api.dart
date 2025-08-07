import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/api_urls.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
   
  Future<InventoryItem?> saveInventoryItem(InventoryItem item) async {
    final String token = Uuid().v4();
    final String testJson = jsonEncode(item.toJson());


     final String test = '$mac_studio_ip:8080$addItemUrl';
     print("API Base URL: $test");
     final String testURl = 'http://192.168.1.111:8080/inventory/add';
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