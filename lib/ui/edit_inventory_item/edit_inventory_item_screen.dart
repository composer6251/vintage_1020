import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/ui/core/ui/widgets/inputform.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel.dart';

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
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          InventoryCarousel(
            width: width / 2,
            height: height / 3,
            flexWeights: [1, 1, 1],
          ),
          Expanded(
            child: InputForm(title: 'Edit Inventory Item', isHorizontal: false),
          ),
        ],
      ),
    );
  }
}
