import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/item_metadata/item_purchase_cost.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booth_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/edit_item_inventory_carousel.dart';
import 'package:vintage_1020/ui/my_booth_tab/widgets/booth_item.dart';
import 'package:vintage_1020/ui/my_booth_tab/widgets/create_booth_widget.dart';
import 'package:vintage_1020/utils/picture_util.dart';

class MyBoothTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyBoothTab> createState() => _MyBoothTabState();
}

class _MyBoothTabState extends ConsumerState<MyBoothTab> {

  late final Future<MyBooth> myBoothFuture;

  @override
  void initState() {
    super.initState();

    myBoothFuture = ref.read(myBoothProvider.notifier).fetchUserBooth();
  }

  @override
  Widget build(BuildContext context) {
    final List<InventoryItemLocal> boothItems = ref.watch(inventoryProvider);

    double inventoryCost = ref.watch(inventoryPurchaseCostProvider);
    double boothValue = ref.watch(inventoryPurchaseCostProvider);

    return Scaffold(
      body: FutureBuilder<MyBooth>(
        future: myBoothFuture, 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if(snapshot.hasError) {
            Center(child: CreateBoothWidget());
          } else if(snapshot.hasData) {
            return
              boothItems.isEmpty 
              ? 
              Center(child: CreateBoothWidget())
              : 
              Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 2,
                  child: Card(
                    elevation: 3.0,
                    shadowColor: Colors.blueAccent,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          style: TextStyle(
                            fontSize: 20, 
                            fontStyle: FontStyle.italic), 
                            'Items:${boothItems.length}'),
                        Text(
                          style: 
                          TextStyle(
                            fontSize: 20, 
                            fontStyle: FontStyle.italic), 
                            'Cost: ${NumberFormat.currency(
                                  symbol: '\$',
                                ).format(inventoryCost)}'),
                        Text(
                          style: 
                          TextStyle(
                            fontSize: 20, 
                            fontStyle: FontStyle.italic), 
                            'Value: ${NumberFormat.currency(
                                  symbol: '\$',
                                ).format(boothValue)}'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InventoryCarousel(
                    inventoryItems: boothItems,
                    flexWeights: [3],
                  ),
                ),
                        // TODO boothItems is filtered inventory by isCurrentBoothItem. Need to make boothImages to be 
                Expanded(
                  flex: 4,
                  child: InventoryCarousel(
                    inventoryItems: boothItems,
                    flexWeights: [3],
                  ),
                ),
                
                // Flexible(
                //   flex: 4,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemExtent: 200,
                //     itemBuilder: (context, index) {
                //       BoothItem(model: boothItems[index]);
                //     },
                //     itemCount: boothItems.length,
                //   ),
                // ),
              ],
              );
                }
                return Center(child: CreateBoothWidget());
            }
            ),
        );
      }
  }


  

