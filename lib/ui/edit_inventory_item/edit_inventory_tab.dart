import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';

class EditItemTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
  
    return Scaffold(
      body: Column(
        children: [
          InventoryCarousel(
            inventoryItems: [],
            width: width,
            height: height * .30,
            flexWeights: [3],
          ),
          InventoryCarousel(
            inventoryItems: [],
            width: width,
            height: height * .25,
            flexWeights: [1, 2, 1],
          ),
        ],
      ),
    );
  }
}
