// import 'package:flutter/material.dart';

// // Create a Form widget.
// class InputFormHorizontal extends StatefulWidget {
//   const InputFormHorizontal({super.key, required this.title, required this.isHorizontal});

//   final String title;
//   final bool isHorizontal;
//   @override
//   State<InputFormHorizontal> createState() => _InputFormHorizontalState();
// }

// class _InputFormHorizontalState extends State<InputFormHorizontal> {
//   final _formKey = GlobalKey<FormState>();
//   String title = '';

//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Form(
//       key: _formKey,
//       child: SizedBox(
//         width: 100,
//         height: 100,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           // spacing: 10,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           // mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               cursorColor: Colors.pink,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//             // TextFormField(
//             //   cursorColor: Colors.pink,
//             //   decoration: InputDecoration(
//             //     labelText: 'Price',
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(20.0),
//             //     ),
//             //   ),
//             //   // The validator receives the text that the user has entered.
//             //   validator: (value) {
//             //     if (value == null || value.isEmpty) {
//             //       return 'Please enter some text';
//             //     }
//             //     return null;
//             //   },
//             // ),
//             DropdownMenu(
//               dropdownMenuEntries: [
//                 DropdownMenuEntry(
//                   label: 'Furniture',
//                   value: 'Furniture',
//                 ),
//                 DropdownMenuEntry(label: 'Lamps', value: 'Lamps'),
//                 DropdownMenuEntry(
//                   label: 'Wall Decor',
//                   value: 'Wall Decor',
//                 ),
//                 DropdownMenuEntry(
//                   label: 'Miscellaneous',
//                   value: 'Miscelaneous',
//                 ),
//               ],
//             ),
//             // TextFormField(
//             //   decoration: InputDecoration(
//             //     labelText: 'Remarks',
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(20.0),
//             //     ),
//             //   ),
//             //   // The validator receives the text that the user has entered.
//             //   validator: (value) {
//             //     if (value == null || value.isEmpty) {
//             //       return 'Please enter some text';
//             //     }
//             //     return null;
//             //   },
//             // ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Validate returns true if the form is valid, or false otherwise.
//                   if (_formKey.currentState!.validate()) {
//                     // If the form is valid, display a snackbar. In the real world,
//                     // you'd often call a server or save the information in a database.
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Processing Data'),
//                       ),
//                     );
//                   }
//                 },
//                 child: const Text('Submit'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
