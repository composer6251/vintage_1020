import 'dart:io';
import 'dart:convert';

import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class InventoryItemLocal {
  String id; // default id on creation
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
  double? itemHeight;
  double? itemWidth;
  double? itemDepth;
  DateTime? itemDeleteDate;
  double? isCurrentBoothItem = 0.0;

  InventoryItemLocal.empty(this.id);

  InventoryItemLocal(
    this.id,
    String? primaryImageUrl,
    String? itemDescription,
    List<String>? itemImageUrls,
    String? itemCategory,
    double? itemPurchasePrice,
    double? itemListingPrice,
    double? itemSoldPrice,
    DateTime? itemPurchaseDate,
    DateTime? itemListingDate,
    DateTime? itemSoldDate,
    double? itemHeight,
    double? itemWidth,
    double? itemDepth,
    DateTime? itemDeleteDate,
    bool isCurrentBoothItem,
  ) :
    primaryImageUrl = primaryImageUrl ?? primaryImageUrl,
    itemDescription = itemDescription ?? itemDescription,
    itemImageUrls = itemImageUrls ?? itemImageUrls,
    itemCategory = itemCategory ?? itemCategory,
    itemPurchasePrice = itemPurchasePrice ?? itemPurchasePrice,
    itemListingPrice = itemListingPrice ?? itemListingPrice,
    itemSoldPrice = itemSoldPrice ?? itemSoldPrice,
    itemPurchaseDate = itemPurchaseDate ?? itemPurchaseDate,
    itemListingDate = itemListingDate ?? itemListingDate,
    itemSoldDate = itemSoldDate ?? itemSoldDate,
    itemHeight = itemHeight ?? itemHeight,
    itemWidth = itemWidth ?? itemWidth,
    itemDepth = itemDepth ?? itemDepth,
    itemDeleteDate = itemDeleteDate ?? itemDeleteDate,
    isCurrentBoothItem = isCurrentBoothItem ? 1.0 : 0.0;

  // InventoryItemLocal.copyWith({
  //   String id,
  //   String? primaryImageUrl,
  //   String? itemDescription,
  //   List<File>? itemImages,
  //   List<String>? itemImageUrls,
  //   String? itemCategory,
  //   double? itemPurchasePrice,
  //   double? itemListingPrice,
  //   double? itemSoldPrice,
  //   DateTime? itemPurchaseDate,
  //   DateTime? itemListingDate,
  //   DateTime? itemSoldDate,
  //   double? itemHeight,
  //   double? itemWidth,
  //   double? itemDepth,
  //   DateTime? itemDeleteDate,
  //   bool isCurrentBoothItem = false,
  // }) {
  //   this.id,
  //   this.primaryImageUrl = primaryImageUrl ?? this.primaryImageUrl;
  //   this.itemDescription = itemDescription ?? this.itemDescription;
  //   this.itemImageUrls = itemImageUrls ?? this.itemImageUrls;
  //   this.itemCategory = itemCategory ?? this.itemCategory;
  //   this.itemPurchasePrice = itemPurchasePrice ?? this.itemPurchasePrice;
  //   this.itemListingPrice = itemListingPrice ?? this.itemListingPrice;
  //   this.itemSoldPrice = itemSoldPrice ?? this.itemSoldPrice;
  //   this.itemPurchaseDate = itemPurchaseDate ?? this.itemPurchaseDate;
  //   this.itemListingDate = itemListingDate ?? this.itemListingDate;
  //   this.itemSoldDate = itemSoldDate ?? this.itemSoldDate;
  //   this.itemHeight = itemHeight ?? this.itemHeight;
  //   this.itemWidth = itemWidth ?? this.itemWidth;
  //   this.itemDepth = itemDepth ?? this.itemDepth;
  //   this.itemDeleteDate = itemDeleteDate ?? this.itemDeleteDate;
  //   this.isCurrentBoothItem = isCurrentBoothItem ? 1.0 : 0.0;
  // }

  InventoryItemLocal.updateItem(
    this.id,
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
  // TODO: ADD GETTERS FOR DETERMINING IF LISTED/SOLD...etc



  List<File>? get getItemImages {
    return itemImageUrls?.map((url) => File(url)).toList();
  }

  File get getPrimaryImage {
    return File(primaryImageUrl!);
  }

  bool get isListed {
    return (itemListingDate != null || itemListingPrice != null || isCurrentBoothItem == 1.0);
  }

  bool get isSold {
    return (itemSoldDate != null || itemSoldPrice != null);
  }

  bool get isDeleted {
    return (itemDeleteDate != null);
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
