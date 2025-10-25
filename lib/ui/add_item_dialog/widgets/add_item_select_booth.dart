import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class AddItemSelectBooth extends StatelessWidget {
  const AddItemSelectBooth({required this.userBooths, required this.onValueUpdated});

  final List<MyBooth> userBooths;
  final Function onValueUpdated;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        userBooths.isEmpty 
        ?
        Container()
        :
        Flexible(
          flex: 3,
          child: DropdownMenu(
            // expandedInsets: EdgeInsets.all(4),
            initialSelection: userBooths.first.boothName,
            onSelected: (value) => onValueUpdated,
            dropdownMenuEntries: userBooths
                .map<DropdownMenuEntry<String>>(
                  (MyBooth booth) => DropdownMenuEntry<String>(
                    leadingIcon: Icon(Icons.storefront),
                    value: booth.boothName,
                    label: booth.boothName,
                  ),
                )
                .toList(),
          ),
        ),
        Divider(height: 4,),
        Flexible(
          flex: 2,
          child: TextFormField(
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              floatingLabelAlignment: FloatingLabelAlignment.center,
              fillColor: Colors.blue,
              labelStyle: TextStyle(
                
                fontSize: 16,
                fontStyle: FontStyle.italic,
                
              ),
              labelText: createBoothInputLabel,
            ),
            onChanged: (value) => onValueUpdated,
            // validator: (value) =>
            //     value?.isEmpty ?? true ? 'Booth Name is required' : null,
          ),
        ),
      ],
    );
  }
}
