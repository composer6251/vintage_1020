import 'dart:math';
import 'package:namer_app/picture_names.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel_viewmodel.dart';

class BuildMockModels {
  static List<InventoryItem> buildInventoryItemModels() {
    List<String> modelList = PictureNames.picListFurniture;
    List<InventoryItem> models = [];
    List<String> categories = ['Furniture', 'Lamp', 'Painting', 'Wall decor'];

    for (var m in modelList) {
      List<String> imageUrls = [m];
      int cat = Random().nextInt(categories.length);
      InventoryItem model = InventoryItem(
        itemImageUrls: imageUrls,
        itemPurchaseDate: DateTime.now(),
        itemPurchasePrice: 100.0,
        itemDescription: "itemDescription",
        itemListingDate: DateTime.now(),
        itemListingPrice: 100.0,
        itemCategory: categories[cat],
      );

      models.add(model);
    }

    return models;
  }

  static InventoryItem buildSingleInventoryModel() {
    List<String> pics = [PictureNames.two];

    /****MOCK MODEL */
    final InventoryItem model = InventoryItem(
      itemImageUrls: pics,
      itemDescription: 'Description',
      itemPurchaseDate: DateTime.now(),
      itemPurchasePrice: 130.00,
      itemListingDate: DateTime.now(),
      itemListingPrice: 200.0,
      itemSoldPrice: 250,
      itemSoldDate: DateTime.now(),
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
      itemImageUrls: pics,
      itemDescription: 'Description',
      itemPurchaseDate: DateTime.now(),
      itemPurchasePrice: 130.00,
      itemListingDate: DateTime.now(),
      itemListingPrice: 200.0,
      itemSoldPrice: 250,
      itemSoldDate: DateTime.now(),
    );

    return model;
  }
}
