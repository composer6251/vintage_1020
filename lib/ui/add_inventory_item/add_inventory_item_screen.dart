// import 'package:flutter/material.dart';
// import 'package:vintage_1020/data/model/inventory_item.dart';
// import 'package:vintage_1020/data/repositories/inventory_repo.dart';
// import 'package:vintage_1020/data/repositories/inventory_repo_server_cache.dart';
// import 'package:vintage_1020/domain/models/mock/build_mock_models.dart';

// class AddInventoryItemScreen extends StatefulWidget {
//   const AddInventoryItemScreen({super.key});

//   @override
//   State<AddInventoryItemScreen> createState() => _AddInventoryItemScreenState();
// }

// class _AddInventoryItemScreenState extends State<AddInventoryItemScreen> {
//   List<InventoryItem> items = [];
//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.sizeOf(context).height;
//     final double width = MediaQuery.sizeOf(context).width;
//     InventoryItem model = BuildMockModels.buildSingleInventoryModel();
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         MaterialButton(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//           onPressed: () => addInventoryItem(model),
//           child: Text('SAVE'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               getInventoryItemStream();
//               print(items);
//             });
//           },
//           child: Text('Get Inventory'),
//         ),
//         // SizedBox(height: height * .35, child: ImageSelector()),
//       ],
//     );
//   }
// }
