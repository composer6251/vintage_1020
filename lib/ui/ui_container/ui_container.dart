import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:vintage_1020/data/local_db/inventory_db.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/ui/activity_chart_screen/activity_chart.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_dialog.dart';
import 'package:vintage_1020/ui/common/widgets/app_bar/custom_app_bar.dart';
import 'package:vintage_1020/ui/common/widgets/app_bar/custom_bottom_navigation_bar.dart';
import 'package:vintage_1020/ui/common/widgets/app_bar/custom_fab.dart';
import 'package:vintage_1020/ui/manage_inventory_screen/widgets/manage_inventory_screen.dart';
import 'package:vintage_1020/ui/my_booths_screen/my_booths_screen.dart';

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
  static List<Widget> _widgetOptions = <Widget>[
    ManageInventoryScreen(),
    MyBoothsScreen(),
    ActivityChart(isShowingMainData: true)
    
  ];

  int _selectedIndex = 0;

  void openAddInventoryDialog() {
    showDialog(context: context, builder: (context) => const AddItemDialog());
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(inventoryLocalProvider);

    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      resizeToAvoidBottomInset: true,
      appBar: 
        PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      bottomNavigationBar: BottomAppBar(
      color: Colors.blue,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: IconButton(
              iconSize: 36,
              onPressed: () => setState(() {
                _selectedIndex = 0;
              }),
                  //Navigator.of(context).pushNamed('/manage-inventory'),
              icon: FaIcon(FontAwesomeIcons.couch),
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              iconSize: 36,
              onPressed: () => setState(() {
                _selectedIndex = 1;
              }),//Navigator.of(context).pushNamed('/my-booths'),
              icon: FaIcon(FontAwesomeIcons.tent),
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              iconSize: 36,
              onPressed: () => setState(() {
                _selectedIndex = 2;
              }),
                  // Navigator.of(context).pushNamed('/inventory-analytics'),
              icon: FaIcon(FontAwesomeIcons.chartBar),
            ),
          ),
          Flexible(
            flex: 2,
            child: OutlinedButton(
              onPressed: openAddInventoryDialog,
              child: Text(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                'Add Item',
              ),
            ),
          ),
        ],
      ),
    ),
      floatingActionButton: CustomFab(),
    );
  }
}
