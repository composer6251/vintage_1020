import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:vintage_1020/data/repositories/inventory_repo_server_cache.dart';
import 'package:vintage_1020/domain/models/mock/build_mock_models.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inputform.dart';
import 'package:vintage_1020/ui/inventory_carousel/inventory_carousel.dart';

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
    List<InventoryItem> defaultModel = [
      BuildMockModels.buildSingleInventoryModelWithImages(),
    ];
    List<InventoryItem> mockModels = BuildMockModels.buildInventoryItemModels();
    getInventoryItemStream().map((event) => {
      print(event)
    },);

    return Scaffold(
      body: Flexible(
        child: Column(
          children: [
            InventoryCarousel(
              models: defaultModel,
              width: width,
              height: height * .30,
              flexWeights: [3],
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
            //   child: InputFormHorizontal(
            //     model: defaultModel.first,
            //     width: width,
            //     height: height * .10,
            //     title: 'Edit Inventory Item',
            //     isHorizontal: false,
            //   ),
            // ),
            InventoryCarousel(
              models: mockModels,
              width: width,
              height: height * .25,
              flexWeights: [1, 2, 1],
            ),
          ],
        ),
      ),
    );
  }
}
