import 'package:flutter/material.dart';

class InventoryItem extends ChangeNotifier {
  InventoryItem({
    required this.itemImageUrls,
    required this.itemDescription,
    required this.itemPurchaseDate,
    required this.itemPurchasePrice,
    this.itemListingDate,
    this.itemListingPrice,
    this.itemSoldPrice,
    this.itemCategory,
    this.defaultItemImageUrl,

    this.itemSoldDate,
  }) {
    itemImageUrls = itemImageUrls;
    itemDescription = itemDescription;
    itemListingDate = itemListingDate;
    itemListingPrice = itemListingPrice;
    itemPurchasePrice = itemPurchasePrice;
    itemSoldPrice = itemSoldPrice;
    itemCategory ?? 'Miscellaneous';
    // TODO: Currently just using the first image as the "main/default" image. Update to user preference my adding "make main image checkbox to singleInventoryItem"
    defaultItemImageUrl = itemImageUrls.first;
  }

  List<String> itemImageUrls;
  String itemDescription;
  double itemPurchasePrice;
  DateTime itemPurchaseDate;

  // Non required fields

  var itemSoldPrice;
  var itemSoldDate;
  var itemListingDate;
  var itemListingPrice;
  var itemCategory;
  var defaultItemImageUrl;
}
