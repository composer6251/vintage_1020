

import 'package:flutter/material.dart';
import 'package:vintage_1020/constants/booth_discounts.dart';

class ThreeDotsMenuSelectWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: '10',
          child: Text('10%')
        ),
        const PopupMenuItem<String>(
          value: '15',
          child: Text('15%')
        ),
        const PopupMenuItem<String>(
          value: '25',
          child: Text('25%')
        )
      ]

      );
  }

  
}