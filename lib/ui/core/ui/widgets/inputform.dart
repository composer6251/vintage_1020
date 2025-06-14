import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel_viewmodel.dart';

// Create a Form widget.
class InputFormHorizontal extends StatefulWidget {
  const InputFormHorizontal({
    super.key,
    required this.title,
    required this.isHorizontal,
    required this.width,
    required this.height,
    required this.model,
  });

  final String title;
  final bool isHorizontal;
  final double width;
  final double height;
  final InventoryItem model;
  @override
  State<InputFormHorizontal> createState() => _InputFormHorizontalState();
}

class _InputFormHorizontalState extends State<InputFormHorizontal> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  DateTime? selectedDate;
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 7, 25),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(height: widget.height / 6, child: Text(style: TextStyle(fontSize: 50), 'Placeholder'),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: widget.width / 10,
            children: [
              SizedBox(
                height: 100,
                width: widget.width / 10,
                child: TextFormField(
                  initialValue: widget.model.itemDescription,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: widget.width / 10,
                child: TextFormField(
                  initialValue: widget.model.itemListingPrice.toString(),
                  decoration: InputDecoration(
                    labelText: 'Listing Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: widget.width / 10,
                child: TextFormField(
                  initialValue: widget.model.itemPurchasePrice.toString(),
                  decoration: InputDecoration(
                    labelText: 'Purchase Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: widget.width / 10,
                child: DropdownMenu(
                  hintText: 'Category',
                  dropdownMenuEntries: [
                    DropdownMenuEntry(label: 'Furniture', value: 'Furniture'),
                    DropdownMenuEntry(label: 'Lamps', value: 'Lamps'),
                    DropdownMenuEntry(label: 'Wall Decor', value: 'Wall Decor'),
                    DropdownMenuEntry(
                      label: 'Miscellaneous',
                      value: 'Miscelaneous',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Purchase Date: ${DateFormat.yMEd().add_jms().format(widget.model.itemPurchaseDate)}'),
                  OutlinedButton(
                    onPressed: _selectDate,
                    child: Text('New Purchase Date'),
                  ),
                ],
              ),
              Column(
                children: [
                  widget.model.itemListingDate == null 
                  ?
                  Text('Listing Date: ${DateFormat.yMEd().add_jms().format(widget.model.itemListingDate)}')
                  :
                  Text('No Item Listing Date')
                  ,
                  OutlinedButton(
                    onPressed: _selectDate,
                    child: Text('New Listing Date'),
                  ),
                ],
              ),
              Column(
                children: [
                  widget.model.itemSoldDate == null 
                  ?
                  Text('Sold Date: ${DateFormat.yMEd().add_jms().format(widget.model.itemSoldDate)}')
                  :
                  Text('No Item Sold Date'),
                  OutlinedButton(
                    onPressed: _selectDate,
                    child: Text('New Sold Date'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
