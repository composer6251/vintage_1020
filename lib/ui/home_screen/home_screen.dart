import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:vintage_1020/constants/inventory_categories.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:vintage_1020/data/repositories/inventory_repo_server_cache.dart';
import 'package:vintage_1020/domain/models/mock/build_mock_models.dart';
import 'package:vintage_1020/providers/inventory_provider.dart';
import 'package:vintage_1020/ui/add_inventory_item/add_inventory_item_screen.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/add_inventory_form_dialog.dart';
import 'package:vintage_1020/ui/edit_inventory_item/edit_inventory_tab.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';
import 'package:vintage_1020/ui/inventory_overview/inventory_overview_tab.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/manage_inventory_screen.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/manage_inventory_screen_stream.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/manage_inventory_tab.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/widgets/activity_chart.dart';

class HomeScreen extends ConsumerWidget {
  final logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InventoryItem> models = [];

    models = BuildMockModels.buildInventoryItemModels();

    void openAddInventoryDialog() {
      showDialog(
        context: context,
        builder: (context) => const AddInventoryFormDialog(),
      );
    }

    return Scaffold(
      body: Column(
        children: [TabViewsContent()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddInventoryDialog,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}

class TabViewsContent extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    // Listen to Inventory updates
    final unfilteredInventory = ref.watch(inventoryNotifierProvider).toList();
    // TODO Add actual filter
    final filteredInventory = unfilteredInventory.where(
      (item) => item.itemCategory == 'Furniture',
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height, maxWidth: width),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue[700],
            bottom: TabBar(
              dividerColor: Colors.white,
              isScrollable: false,
              indicatorAnimation: TabIndicatorAnimation.elastic,
              automaticIndicatorColorAdjustment: true,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Inventory', icon: Icon(Icons.favorite)),
                Tab(text: 'Manage', icon: Icon(Icons.chair_rounded)),
                Tab(text: 'Edit', icon: Icon(Icons.chair)),
                Tab(text: 'Sales', icon: Icon(Icons.attach_money)),
              ],
            ),
          ),
          body: TabBarView(
            // controller: TabController(length: 0, vsync: ),
            children: [
              InventoryOverviewTab(),
              ManageInventoryTab(),
              EditItemTab(),
              ActivityChart(isShowingMainData: true),
            ],
          ),
        ),
      ),
    );
  }
}
