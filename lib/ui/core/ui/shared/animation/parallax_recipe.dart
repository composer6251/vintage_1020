import 'package:flutter/material.dart';
import 'package:namer_app/picture_names.dart';
import 'package:namer_app/ui/inventory_parallax/inventory_item_parallax.dart';

class ParallaxRecipe extends StatelessWidget {
  const ParallaxRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
      children: [
        for (final picture in PictureNames.picListFurniture)
            InventoryItemParallax(
              imageUrl: picture,
            ),
      ]
      )
      );
  }
}