
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/domain/providers/firestore_provider/firestore_provider.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';

class MyBoothTab extends ConsumerStatefulWidget {
  // late final Future<void> _itemsFuture;

  @override
  ConsumerState<MyBoothTab> createState() => _MyBoothTabState();
}

class _MyBoothTabState extends ConsumerState<MyBoothTab> {
  late Future<void> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = ref
        .read(firestoreProviderProvider.notifier)
        .getUserCollectionId();
    // _itemsFuture = ref
    //     .read(firestoreProviderProvider.notifier)
    //     .fetchAllInventoryTest();
    }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    final items = ref.watch(firestoreProviderProvider);
    return Scaffold(
      body: FutureBuilder(
        /*FUTURE FUNCTION TO RETRIEVE DATA AND UPDATE PROVIDER*/
        future: _itemsFuture,
        builder: (context, asyncSnapshot) {
          // AFTER THE ASYNC CALL FINISHES, HANDLE THE RETURN
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${asyncSnapshot.error}'),
            );
          } else if (asyncSnapshot.hasData) {
            print(asyncSnapshot);
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                InventoryCarousel(
                  models: items,
                  width: width,
                  height: height * .50,
                  flexWeights: [3],
                ),

                InventoryCarousel(
                  models: items,
                  width: width,
                  height: height * .40,
                  flexWeights: [1, 2, 1],
                ),
                // TextButton(onPressed:() => getInventoryByEmail(userEmail), child: Text('Refresh Inventory'))
              ],
            );
          }

          return Center(
            child: Text('No inventory Items. Click the PLUS sign to add'),
          );
        },
      ),
    );
  }
}
