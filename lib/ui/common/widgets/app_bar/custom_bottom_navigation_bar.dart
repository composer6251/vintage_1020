import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_dialog.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void openAddInventoryDialog() {
        showDialog(context: context, builder: (context) => const AddItemDialog());
    }

    return BottomAppBar(
      color: Colors.blue,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: IconButton(
              iconSize: 36,
              onPressed: () =>
                  Navigator.of(context).pushNamed('/manage-inventory'),
              icon: FaIcon(FontAwesomeIcons.couch),
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              iconSize: 36,
              onPressed: () => Navigator.of(context).pushNamed('/my-booths'),
              icon: FaIcon(FontAwesomeIcons.tent),
            ),
          ),
          // Flexible(
          //   flex: 1,
          //   child: IconButton(
          //     iconSize: 36,
          //     onPressed: () =>
          //         Navigator.of(context).pushNamed('/inventory-analytics'),
          //     icon: FaIcon(FontAwesomeIcons.chartBar),
          //   ),
          // ),
          Flexible(
            flex: 1,
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
    );
  }
}
