import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:vintage_1020/domain/models/mock/build_mock_models.dart';
import 'package:vintage_1020/providers/inventory_provider.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/add_inventory_form_dialog.dart';
import 'package:vintage_1020/ui/edit_inventory_item/edit_inventory_tab.dart';
import 'package:vintage_1020/ui/inventory_overview/inventory_overview_tab.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/manage_inventory_tab.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/widgets/activity_chart.dart';
import 'package:vintage_1020/ui/my_booth_tab/my_booth_tab.dart';

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
        shape: CircleBorder(
          side: BorderSide(color: Colors.blue, width: 2.0),
        ),
        onPressed: openAddInventoryDialog,
        backgroundColor: Colors.blue,
        child: Icon(size: 40.0, Icons.add),
      ),
    );
  }
}

class TabViewsContent extends ConsumerStatefulWidget {

  @override
  _TabViewsContentState createState() => _TabViewsContentState();
}

class _TabViewsContentState extends ConsumerState<TabViewsContent> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Inventory', icon: Icon(Icons.favorite)),
    Tab(text: 'My Booth', icon: Icon(Icons.storefront)),
    Tab(text: 'Manage', icon: Icon(Icons.chair_rounded)),
    Tab(text: 'Edit', icon: Icon(Icons.price_check)),   
    Tab(text: 'Sales', icon: Icon(Icons.bar_chart)),
  ];

    @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

 @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    // Listen to Inventory updates
    final unfilteredInventory = ref.watch(inventoryNotifierProvider).toList();
    // TODO Add actual filter
    final filteredInventory = unfilteredInventory.where(
      (item) => item.itemCategory == 'Furniture',
    );
    // TODO: Create tab controller and pass to children to change index

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height, maxWidth: width),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue[700],
          bottom: TabBar(
            controller: _tabController,
            dividerColor: Colors.white,
            isScrollable: false,
            indicatorAnimation: TabIndicatorAnimation.elastic,
            automaticIndicatorColorAdjustment: false,
            unselectedLabelColor: Colors.white38,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              ...myTabs,
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            InventoryOverviewTab(),
            MyBoothTab(),
            ManageInventoryTab(
              controller: _tabController,
            ),
            EditItemTab(),
            ActivityChart(isShowingMainData: true),
          ],
        ),
      ),
    );
  }
}
