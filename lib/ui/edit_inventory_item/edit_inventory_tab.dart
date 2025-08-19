import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/repositories/inventory_repo_server_cache.dart';
import 'package:vintage_1020/domain/models/mock/build_mock_models.dart';
import 'package:vintage_1020/providers/inventory/inventory.dart';
import 'package:vintage_1020/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';

class EditItemTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    // final items = ref.watch(inventoryNotifierProvider);
    // final inventoryItems = userEmail != null ? ref.watch(getUserInventoryProvider(userEmail : userEmail)) : [];
    // ref.watch(provider)
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    
    // TODO implement actual inventory item stream
    getInventoryItemStream().map((event) => {print(event)});

    return Scaffold(
      body: Column(
        children: [
          InventoryCarousel(
            width: width,
            height: height * .30,
            flexWeights: [3],
          ),
          InventoryCarousel(
            width: width,
            height: height * .25,
            flexWeights: [1, 2, 1],
          ),
        ],
      ),
    );
  }
}
