


// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:vintage_1020/providers/inventory_provider/inventory_provider.dart';

// class TabViewsContent extends HookConsumerWidget {
//   const TabViewsContent({super.key, 
//   // required this.userEmail
//   });

//   // final String userEmail;

//   // @override
//   // TabViewsContentState createState() => TabViewsContentState();
//   // final String userEmail;
//   // late TabController _tabController;
//   static const  List<Tab> myTabs = <Tab>[
//     Tab(text: 'My Booth', icon: Icon(Icons.storefront)),
//     Tab(text: 'Manage', icon: Icon(Icons.chair_rounded)),
//     Tab(text: 'Edit', icon: Icon(Icons.price_check)),   
//     Tab(text: 'Sales', icon: Icon(Icons.bar_chart)),
//   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(vsync: this, length: myTabs.length);
// //   }

// //  @override
// //  void dispose() {
// //    _tabController.dispose();
// //    super.dispose();
// //  }
//   @override
//   Widget build(BuildContext context, Ref ref) {
//     //     void useOnInit(Function action) {
//     //   useEffect(() {
//     //     WidgetsBinding.instance.addPostFrameCallback(
//     //       (_) => action(),
//     //     );
//     //     return null;
//     //   }, []);
//     // }
//     // useOnInit(() {
//     //   userEmail = widget.userEmail;
//     //   ref.read(userNotifierProvider.notifier).setUserEmail(userEmail);
//     // });
//     //   ref.read(inventoryNotifierProvider.notifier).fetchUserInventory(userEmail);

//     final inventoryItems = r
//     final double height = MediaQuery.sizeOf(context).height;
//     final double width = MediaQuery.sizeOf(context).width;

//     // Listen to Inventory updates
//     final unfilteredInventory = ref.watch(inventoryNotifierProvider).toList();
//     // TODO Add actual filter
//     final filteredInventory = unfilteredInventory.where(
//       (item) => item.itemCategory == 'Furniture',
//     );
//     // TODO: Create tab controller and pass to children to change index

//     return ConstrainedBox(
//       constraints: BoxConstraints(maxHeight: height, maxWidth: width),
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.blue[700],
//           bottom: TabBar(
//             controller: _tabController,
//             dividerColor: Colors.white,
//             isScrollable: false,
//             indicatorAnimation: TabIndicatorAnimation.elastic,
//             automaticIndicatorColorAdjustment: false,
//             unselectedLabelColor: Colors.white38,
//             indicatorColor: Colors.white,
//             labelColor: Colors.white,
//             tabs: [
//               ...myTabs,
//             ],
//           ),
//         ),
//         body: TabBarView(
//           controller: _tabController,
//           physics: NeverScrollableScrollPhysics(),
//           children: [
//             // InventoryOverviewTab(),
//             MyBoothTab(),
//             ManageInventoryTab(
//               controller: _tabController,
//             ),
//             EditItemTab(),
//             ActivityChart(isShowingMainData: true),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class TabViewsContentState extends ConsumerState<TabViewsContent> with TickerProviderStateMixin {

  
// // }