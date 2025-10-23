import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/manage_inventory_tab.dart';
import 'package:vintage_1020/ui/activity_chart_screen/activity_chart.dart';
import 'package:vintage_1020/ui/my_booth_tab/my_booth_tab.dart';

class UiContainer extends ConsumerStatefulWidget {
  UiContainer({super.key});

  final logger = Logger(printer: PrettyPrinter());

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<UiContainer> {

  void showSnackBar(String message) {
    var sb = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(sb);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [TabViewsContent()],
        ),
      ),
    );
  }
}

class TabViewsContent extends ConsumerWidget {
   TabViewsContent({super.key});

  static List<Tab> myTabs = <Tab>[
    Tab(text: 'Manage', icon: Icon(Icons.chair_rounded)),
    Tab(text: 'My Booth', icon: Icon(Icons.storefront)),
    Tab(text: 'Sales', icon: Icon(Icons.bar_chart)),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    final FirebaseAuth auth = FirebaseAuth.instance;

    return DefaultTabController(
      length: myTabs.length,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height, maxWidth: width),
        child: Scaffold(
          appBar: AppBar(
            title: Text('WELCOME VINTAGE 1020!!!'),
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            centerTitle: true,
            toolbarHeight: 40,
            elevation: 100,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue[700],
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  auth.signOut();
                },
              ),
            ],
            bottom: TabBar(
              dividerColor: Colors.white,
              isScrollable: false,
              indicatorAnimation: TabIndicatorAnimation.elastic,
              automaticIndicatorColorAdjustment: false,
              unselectedLabelColor: Colors.white38,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: [...myTabs],
              onTap: (value) => ref
                  .read(filterProvider.notifier)
                  .setCurrentTabInventoryFilter(value),
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              ManageInventoryTab(),
              MyBoothTab(),
              ActivityChart(isShowingMainData: true),
            ],
          ),
        ),
      ),
    );
  }
}
