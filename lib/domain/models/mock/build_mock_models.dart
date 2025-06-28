import 'dart:math';
import 'package:vintage_1020/constants/inventory_categories.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:vintage_1020/picture_names.dart';

class BuildMockModels {
  static List<InventoryItem> buildInventoryItemModels() {
    List<String> modelList = PictureNames.picListFurniture;
    List<InventoryItem> models = [];

    for (var m in modelList) {
      List<String> imageUrls = [m];
      InventoryItem model = InventoryItem(
        id: '',
        itemImageUrls: imageUrls,
        itemPurchaseDate: DateTime.now(),
        itemPurchasePrice: 100.0,
        itemDescription: "itemDescription",
        itemListingDate: DateTime.now(),
        itemListingPrice: 100.0,
        itemCategory: InventoryCategory.furniture,
      );

      models.add(model);
    }

    return models;
  }

  static InventoryItem buildSingleInventoryModel() {
    List<String> pics = [PictureNames.two];

    /****MOCK MODEL */
    final InventoryItem model = InventoryItem(
      id: '',
      itemImageUrls: pics,
      itemDescription: 'Description',
      itemPurchaseDate: DateTime.now(),
      itemPurchasePrice: 130.00,
      itemListingDate: DateTime.now(),
      itemListingPrice: 200.0,
      itemSoldPrice: 250,
      itemSoldDate: DateTime.now(),
      itemCategory: InventoryCategory.furniture,

    );

    return model;
  }

  static InventoryItem buildSingleInventoryModelWithImages() {
    List<String> pics = [
      PictureNames.lunaFurnitureOne,
      PictureNames.lunaFurnitureTwo,
      PictureNames.lunaFurnitureThree,
    ];

    /****MOCK MODEL */
    final InventoryItem model = InventoryItem(
      id: '',
      itemImageUrls: pics,
      itemDescription: 'Description',
      itemPurchaseDate: DateTime.now(),
      itemPurchasePrice: 130.00,
      itemListingDate: DateTime.now(),
      itemListingPrice: 200.0,
      itemSoldPrice: 250,
      itemSoldDate: DateTime.now(),
      itemCategory: InventoryCategory.furniture,

    );

    return model;
  }
}
