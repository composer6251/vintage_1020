// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:vintage_1020/data/model/inventory_item.dart';
// import 'package:vintage_1020/ui/inventory_carousel/inventory_carousel_viewmodel.dart';

// // Create a Form widget.
// class InputFormHorizontal extends StatefulWidget {
//    InputFormHorizontal({
//     super.key,
//     required this.title,
//     required this.isHorizontal,
//     required this.width,
//     required this.height,
//     this.model,
//   });

//   final String title;
//   final bool isHorizontal;
//   final double width;
//   final double height;
//   late final InventoryItem? model;
//   @override
//   State<InputFormHorizontal> createState() => _InputFormHorizontalState();
// }

// class _InputFormHorizontalState extends State<InputFormHorizontal> {
  
//   final _formKey = GlobalKey<FormState>();
//   String title = '';
//   DateTime? selectedDate;
//   Future<void> _selectDate() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2021, 7, 25),
//       firstDate: DateTime(2021),
//       lastDate: DateTime(2022),
//     );

//     setState(() {
//       selectedDate = pickedDate;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             spacing: widget.width *.05,
//             children: [
//               SizedBox(
//                 width: widget.width / 5,
//                 height: widget.height,
//                 child: TextFormField(
//                   initialValue: widget.model?.itemDescription,
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.teal),
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.tealAccent, width: 2),
//                       borderRadius: BorderRadius.all(Radius.circular(15.0))
//                     )
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: widget.width / 5,
//                 height: widget.height,
//                 child: TextFormField(
//                   initialValue: widget.model?.itemListingPrice.toString(),
//                   decoration: InputDecoration(
//                     labelText: 'Listing Price',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: widget.width / 5,
//                 height: widget.height,
//                 child: TextFormField(
//                   initialValue: widget.model?.itemPurchasePrice.toString(),
//                   decoration: InputDecoration(
//                     labelText: 'Purchase Price',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: widget.width / 5,
//                 height: widget.height,
//                 child: DropdownMenu(
//                   hintText: 'Category',
//                   dropdownMenuEntries: [
//                     DropdownMenuEntry(label: 'Furniture', value: 'Furniture'),
//                     DropdownMenuEntry(label: 'Lamps', value: 'Lamps'),
//                     DropdownMenuEntry(label: 'Wall Decor', value: 'Wall Decor'),
//                     DropdownMenuEntry(
//                       label: 'Miscellaneous',
//                       value: 'Miscelaneous',
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               SizedBox(
//                 width: widget.width / 4,
//                 child: Column(
//                   children: [
//                     Text(overflow: TextOverflow.clip, DateFormat.yMEd().add_jms().format(widget.model!.itemPurchaseDate)),
//                     OutlinedButton(
//                       onPressed: _selectDate,
//                       child: Text('New Purchase Date'),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: widget.width / 4,
//                 child: Column(
//                   children: [
//                     widget.model!.itemListingDate == null 
//                     ?
//                     Text(overflow: TextOverflow.clip, 'Listing Date: ${DateFormat.yMEd().add_jms().format(widget.model.itemListingDate)}')
//                     :
//                     Text(overflow: TextOverflow.clip, 'No Item Listing Date')
//                     ,
//                     OutlinedButton(
//                       onPressed: _selectDate,
//                       child: Text('New Listing Date'),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: widget.width / 3,
//                 child: Column(
//                   children: [
//                     widget.model?.itemSoldDate == null 
//                     ?
//                     Text(overflow: TextOverflow.clip, 'Sold Date: ${DateFormat.yMEd().add_jms().format(widget.model?.itemSoldDate)}')
//                     :
//                     Text(overflow: TextOverflow.clip, 'No Item Sold Date'),
//                     OutlinedButton(
//                       onPressed: _selectDate,
//                       child: Text('New Sold Date'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
