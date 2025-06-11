import 'package:flutter/material.dart';

class InventoryItem extends ChangeNotifier {
  InventoryItem({
    required this.itemImageUrl,
    required this.itemDescription,
    required this.itemPurchaseDate,
    required this.itemPurchasePrice,
    this.itemListingDate,
    this.itemListingPrice,
    this.itemSoldPrice,
    this.itemCategory,

    this.itemSoldDate,
  }) {
    itemImageUrl = itemImageUrl;
    itemDescription = itemDescription;
    itemListingDate = itemListingDate;
    itemListingPrice = itemListingPrice;
    itemPurchasePrice = itemPurchasePrice;
    itemSoldPrice = itemSoldPrice;
    itemCategory ?? 'Miscellaneous';
  }

  String itemImageUrl;
  String itemDescription;
  double itemPurchasePrice;
  DateTime itemPurchaseDate;

  // Non required fields

  var itemSoldPrice;
  var itemSoldDate;
  var itemListingDate;
  var itemListingPrice;
  var itemCategory;
}
