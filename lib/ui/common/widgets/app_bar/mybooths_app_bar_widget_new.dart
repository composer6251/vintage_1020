import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/ui/common/dropdowns/select_booth_dropdown_widget.dart';

class MyBoothsAppBarNew extends ConsumerWidget {
  @override
  AppBar build(BuildContext context, WidgetRef ref) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final userBooths = ref.watch(myBoothsProvider);

    return AppBar(
      
      actions: [

        IconButton(onPressed: auth.signOut, icon: Icon(Icons.logout_outlined)),
      ],
      backgroundColor: Colors.blue,
      title: SelectBoothDropDown(userBooths: userBooths)
      
    );
  }
}
