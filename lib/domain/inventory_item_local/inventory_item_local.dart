import 'dart:io';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';
final Uuid uuid = Uuid();
class InventoryItemLocal {
  @Default(Uuid())
  String id;
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
  int? itemHeight;
  int? itemWidth;
  int? itemDepth;
  @Default(null)
  DateTime? itemDeleteDate;
  double? isCurrentBoothItem;

  InventoryItemLocal.empty(uuid.v4());

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
    this.itemHeight,
    this.itemWidth,
    this.itemDepth,
    this.itemDeleteDate,
    this.isCurrentBoothItem,
  );

  InventoryItemLocal.fromLocalDB(Map<String, dynamic> data)
    : id = data['id'],
      userEmail = data?['email'],
      primaryImageUrl = data?['primaryImageUrl'],
      itemDescription = data['itemDescription'],
      itemImageUrls = data['itemImageUrls'] != null
          ? List<String>.from(jsonDecode(data['itemImageUrls']))
          : null, // sqflite strings back to list of strings
      itemCategory = data['itemCategory'],
      itemPurchasePrice = data['itemPurchasePrice'],
      itemListingPrice = data['itemListingPrice'],
      itemSoldPrice = data['itemSoldPrice'],
      itemPurchaseDate = data['itemPurchaseDate'] != null
          ? DateTime.parse(data['itemPurchaseDate']) as DateTime?
          : null,
      itemListingDate = data['itemListingDate'] != null
          ? DateTime.parse(data['itemListingDate']) as DateTime?
          : null,
      itemSoldDate = data['itemSoldDate'] != null
          ? DateTime.parse(data['itemSoldDate']) as DateTime?
          : null,
      itemHeight = data?['itemHeight'],
      itemWidth = data?['itemWidth'],
      itemDepth = data?['itemDepth'],
      // itemDimensions = data?['itemDimensions'] is Iterable?
      //     ? Map.from(data?['itemDimensions'])
      //     : null,
      itemDeleteDate = data['itemDeleteDate'] != null
          ? DateTime.parse(data['itemDeleteDate']) as DateTime?
          : null,
      isCurrentBoothItem = data['isCurrentBoothItem'] as double?;

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
      "itemHeight": itemHeight,
      "itemWidth": itemWidth,
      "itemDepth": itemDepth,
      "itemDeleteDate": itemDeleteDate?.toIso8601String(),
      "isCurrentBoothItem": isCurrentBoothItem,
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
      itemHeight = json['itemHeight'],
      itemWidth = json['itemWidth'],
      itemDepth = json['itemDepth'];

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
    'itemHeight': itemHeight,
    'itemWidth': itemWidth,
    'itemDepth': itemDepth,
    'itemDeleteDate': itemDeleteDate,
    'isCurrentBoothItem': isCurrentBoothItem,
  };
}
