import 'package:flutter/material.dart';

class InventoryItem extends ChangeNotifier {
  InventoryItem({
    required this.itemImageUrl,
    required this.itemDescription,
    required this.itemListingDate,
    required this.itemPrice,
  }) {
    itemImageUrl = itemImageUrl;
    itemDescription = itemDescription;
    itemListingDate = itemListingDate;
    itemPrice = itemPrice;
  }

  String itemImageUrl;
  String itemDescription;
  String itemListingDate;
  String itemPrice;
}
