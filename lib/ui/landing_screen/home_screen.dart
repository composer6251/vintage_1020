import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/data/model/inventory.dart';
import 'package:namer_app/domain/models/mock/build_mock_models.dart';
import 'package:namer_app/inventory_provider.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel.dart';

class HomeScreen extends StatelessWidget {
  final String title = 'HELLO BEAUTIFUL!!';
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory for Vintage 1020!'),
        backgroundColor: Colors.blueAccent,
        bottomOpacity: 100,
      ),
      body: InventoryCarousel(
        images: BuildMockModels.buildInventoryItemModels(),
        height: height,
        width: width,
        flexWeights: [1, 7, 1],
      ),
    );
  }
}

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer(
      // ref enables the UI to read providers
      builder: (context, ref, child) {
        // inventoryProvider is built by the @riverpod annotation on the inventory method in inventory_provider.dart
        final AsyncValue<Inventory> items = ref.watch(inventoryProvider);

        return Container(
          child: switch (items) {
            AsyncData(:final value) => Text('Item: ${value}'),
            AsyncError() => const Text(''),
            _ => const CircularProgressIndicator(),
          },
        );
      },
    );
  }
}
