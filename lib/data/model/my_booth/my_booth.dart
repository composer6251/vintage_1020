import 'dart:io';
import 'dart:convert';

import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';


/// DATA CLASS FOR MY_BOOTH_TAB
class MyBooth {
  final String id;
  String? userEmail;
  List<String>? currentBoothImageUrls;
  /****IF LISTED and NOT SOLD AND NOT ARCHIVED */
  // TODO: Use inventoryProviderToPopulate
  List<InventoryItemLocal>? currentListedInventory;

  MyBooth(
    this.id,
    this.userEmail,
    this.currentBoothImageUrls,
    this.currentListedInventory,
  );

  MyBooth.fromLocalDB(Map<String, dynamic> data)
    : id = data['id'],
      userEmail = data?['email'],
      currentBoothImageUrls = data?['currentBoothImageUrls'] != null 
          ? List<String>.from(jsonDecode(data['currentBoothImageUrls'])) : [];

  Map<String, dynamic> toMapForLocalDB() {
    return <String, dynamic>{
      "id": id,
      "email": userEmail,
      "currentBoothImageUrls": currentBoothImageUrls,
    };
  }


  MyBooth.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      currentBoothImageUrls = json['currentBoothImageUrls'],
      userEmail = json['email'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': userEmail,
    'currentBoothImageUrls': currentBoothImageUrls,
  };
}
