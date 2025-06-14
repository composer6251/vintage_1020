import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/picture_names.dart';
import 'package:namer_app/ui/core/ui/widgets/inputform.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel_viewmodel.dart';

class EditInventoryItemScreen extends ConsumerStatefulWidget {
  const EditInventoryItemScreen({super.key});

  // final InventoryItem model;

  @override
  ConsumerState<EditInventoryItemScreen> createState() =>
      _EditInventoryItemScreenState();
}

class _EditInventoryItemScreenState
    extends ConsumerState<EditInventoryItemScreen> {
  @override
  Widget build(BuildContext context) {
    /****MOCK MODEL */
    final InventoryItem model = InventoryItem(
      itemImageUrl: PictureNames.two,
      itemDescription: 'Description',
      itemPurchaseDate: DateTime.now(),
      itemPurchasePrice: 130.00,
      itemListingDate: DateTime.now(),
      itemListingPrice: 200.0,
      itemSoldPrice: 250,
      itemSoldDate: DateTime.now(),
    );
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          InventoryCarousel(
            width: width,
            height: height / 4,
            flexWeights: [1, 1, 1],
          ),
          InputFormHorizontal(
            model: model,
            width: width,
            height: height,
            title: 'Edit Inventory Item',
            isHorizontal: false,
          ),
        ],
      ),
    );
  }
}
