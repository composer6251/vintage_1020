import 'package:flutter/material.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';

class CustomAppBar extends StatelessWidget {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        'Welcome, $userEmail!!',
      ),
    );
  }
}
