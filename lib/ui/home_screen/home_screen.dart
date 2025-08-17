import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:vintage_1020/data/api/b_t_api/b_t_api.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:vintage_1020/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/providers/user_provider/user_provider.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/add_inventory_form_dialog.dart';
import 'package:vintage_1020/ui/edit_inventory_item/edit_inventory_tab.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/manage_inventory_tab.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/widgets/activity_chart.dart';
import 'package:vintage_1020/ui/my_booth_tab/my_booth_tab.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  HomeScreen({super.key, 
  // required this.userEmail
  });
  final logger = Logger(printer: PrettyPrinter());
  
  // final String userEmail;
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends ConsumerState<HomeScreen> {

    final FirebaseAuth auth = FirebaseAuth.instance;

    @override
    void initState() {
      super.initState();
      // if(mounted) {
      //   // Set user email in provider
      //   ref.read(userNotifierProvider.notifier).setUserEmail(widget.userEmail);
      //   final userEmail = ref.read(userNotifierProvider).userEmail;
      //   Future<List<InventoryItem?>?> inventory = getInventoryByUserEmail(userEmail);
      // }
    }

    void openAddInventoryDialog() {
      showDialog(
        context: context,
        builder: (context) => const AddInventoryFormDialog(),
      );
    }

    void fetchState() {
      
    }
  
  @override
  Widget build(BuildContext context) {

    final apiDataAsync = ref.watch(inventoryNotifierProvider);
    void useOnInit(Function action) {
      useEffect(() {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => action(),
        );
        return null;
      }, []);
    }

    // useOnInit(() => ref.read(inventoryNotifierProvider.notifier).fetchUserInventory(widget.userEmail));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              auth.currentUser?.sendEmailVerification();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [TabViewsContent(
          // userEmail: widget.userEmail
          )],
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
  const TabViewsContent({super.key, 
  // required this.userEmail
  });

  // final String userEmail;

  @override
  TabViewsContentState createState() => TabViewsContentState();
}

class TabViewsContentState extends ConsumerState<TabViewsContent> with TickerProviderStateMixin {
  late final String userEmail;
  late TabController _tabController;

  final List<Tab> myTabs = <Tab>[
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
        void useOnInit(Function action) {
      useEffect(() {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => action(),
        );
        return null;
      }, []);
    }
    // useOnInit(() {
    //   userEmail = widget.userEmail;
    //   ref.read(userNotifierProvider.notifier).setUserEmail(userEmail);
    // });
    //   ref.read(inventoryNotifierProvider.notifier).fetchUserInventory(userEmail);

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
            // InventoryOverviewTab(),
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
