import 'dart:io';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vintage_1020/data/model/json_converters/TimestampConverter.dart';
import 'package:vintage_1020/domain/sqflite/local_db.dart';

class InventoryItemLocal {
  final String id;
  String? userEmail;
  String? primaryImageUrl;
  String? itemDescription;
  List<File>? itemImages;
  List<String>? itemImageUrls;
  String? itemCategory;
  double? itemPurchasePrice;
  double? itemListingPrice;
  double? itemSoldPrice;
  DateTime? itemPurchaseDate;
  DateTime? itemListingDate;
  DateTime? itemSoldDate;
  Map<String, String>? itemDimensions;
  // TODO ADD itemImageUrls List -> String, String ...etc
  InventoryItemLocal.toLocalDb(
    this.id,
    this.userEmail,
    this.primaryImageUrl,
    this.itemDescription,
    this.itemImageUrls,
    this.itemCategory,
    this.itemPurchasePrice,
    this.itemListingPrice,
    this.itemSoldPrice,
    this.itemPurchaseDate,
    this.itemListingDate,
    this.itemSoldDate,
    this.itemDimensions,
  );

  InventoryItemLocal.fromLocalDB(Map<String, dynamic> data)
    : id = data['id'],
      userEmail = data?['email'],
      primaryImageUrl = data?['primaryImageUrl'],
      itemDescription = data['itemDescription'],
      itemImageUrls = data['itemImageUrls'] != null
          ? List<String>.from(jsonDecode(data['itemImageUrls']))
          : [], // sqflite strings back to list of strings
      itemCategory = data['itemCategory'],
      itemPurchasePrice = data['itemPurchasePrice'],
      itemListingPrice = data['itemListingPrice'],
      itemSoldPrice = data['itemSoldPrice'],
      itemPurchaseDate = DateTime.parse(data['itemPurchaseDate']) as DateTime?,
      itemListingDate = DateTime.parse(data['itemListingDate']) as DateTime?,
      itemSoldDate = DateTime.parse(data['itemSoldDate']) as DateTime?,
      itemDimensions = data['itemDimensions'] is Iterable
          ? Map.from(data?['itemDimensions'])
          : null;

  Map<String, dynamic> toMapForLocalDB() {
    return <String, dynamic>{
      "id": id,
      "email": userEmail,
      "primaryImageUrl": primaryImageUrl,
      "itemDescription": itemDescription,
      "itemImageUrls": jsonEncode(itemImageUrls),
      "itemCategory": itemCategory,
      "itemPurchasePrice": itemPurchasePrice,
      "itemListingPrice": itemListingPrice,
      "itemSoldPrice": itemSoldPrice,
      "itemPurchaseDate": itemPurchaseDate?.toIso8601String(),
      "itemListingDate": itemListingDate?.toIso8601String(),
      "itemSoldDate": itemSoldDate?.toIso8601String(),
      "itemDimensions": itemDimensions,
    };
  }

  List<File>? get getItemImages {
    return itemImageUrls?.map((url) => File(url)).toList();
  }

  File get getPrimaryImage {
    return File(primaryImageUrl!);
  }

  InventoryItemLocal.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      primaryImageUrl = json['primaryImageUrl'],
      itemDescription = json['itemDescription'],
      itemImageUrls = json['itemImageUrls'],
      itemCategory = json['itemPurchaitemCategoryDate'],
      itemPurchasePrice = json['itemPurchasePrice'],
      itemListingPrice = json['itemListingPrice'],
      itemSoldPrice = json['itemSoldPrice'],
      itemPurchaseDate = json['itemPurchaseDate'] as DateTime,
      itemListingDate = json['itemListingDate'] as DateTime,
      itemSoldDate = json['itemSoldDate'] as DateTime,
      itemDimensions = json['itemDimensions'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'primaryImageUrl': primaryImageUrl,
    'itemDescription': itemDescription,
    'itemImageUrls': itemImageUrls,
    'itemCategory': itemCategory,
    'itemPurchasePrice': itemPurchasePrice,
    'itemListingPrice': itemListingPrice,
    'itemSoldPrice': itemSoldPrice,
    'itemPurchaseDate': itemPurchaseDate,
    'itemListingDate': itemListingDate,
    'itemSoldDate': itemSoldDate,
    'itemDimensions': itemDimensions,
  };
}
