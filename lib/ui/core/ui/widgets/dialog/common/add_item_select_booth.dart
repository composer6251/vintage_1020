import 'package:flutter/material.dart';


class AddItemSelectBooth extends StatefulWidget{
  
  AddItemSelectBooth({required this.boothNames});

  final List<String> boothNames;
  
  @override
  State<StatefulWidget> createState() => _AddItemSelectBoothState();

}

class _AddItemSelectBoothState extends State<AddItemSelectBooth> { 


  @override
  Widget build(BuildContext context) {

    widget.boothNames.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    return 
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                prefixText: '\$',
                fillColor: Colors.blue,
                labelText: 'Booth Name(required)',
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Booth Name is required' : null,
            ),
          ),

          Flexible(
            child: DropdownMenu(
              initialSelection: widget.boothNames.first,
              // onSelected: (value) => ,
              dropdownMenuEntries: widget.boothNames.map<DropdownMenuEntry<String>>((String boothName) => 
                DropdownMenuEntry<String>(
                  value: boothName,
                  label: boothName,
                )
              ).toList(),
            ),
          ),
      ],
    );
  }
}