// import 'package:flutter/widgets.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
// import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

// class ItemDimensionsDial extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _ItemDimensionsDialState();
// }

// class _ItemDimensionsDialState extends ConsumerState<ItemDimensionsDial> {
//   @override
//   Widget build(BuildContext context) {
//     InventoryItemLocal item = ref.watch(currentInventoryItemProvider);

//     List<int> measurements = List<int>.generate(120, (index) => index);

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Align(
//           alignment: AlignmentGeometry.topLeft,
//           child: Text(
//             textAlign: TextAlign.start,
//             style: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 24),
//             'H:',
//           ),
//         ),
//         SizedBox(
//           height: 100,
//           width: 50,
//           child: ListWheelScrollView.useDelegate(
//             itemExtent: 50,
//             diameterRatio: 1.5,
//             squeeze: 2,
//             controller: FixedExtentScrollController(
//               initialItem: 24,
//             ),
//             physics: const FixedExtentScrollPhysics(),
//             onSelectedItemChanged: (value) {},
//             childDelegate: ListWheelChildBuilderDelegate(
//               childCount: measurements.length,
//               builder: (context, index) =>
//                   Text(style: TextStyle(
//                     fontSize: 24), '- ${measurements[index].toString()} -'),
//             ),
//           ),
//         ),
//         Align(
//           alignment: AlignmentGeometry.bottomLeft,
//           child: Text(
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             'W:',
//           ),
//         ),
//         SizedBox(
//           height: 100,
//           width: 50,
//           child: ListWheelScrollView.useDelegate(
//             itemExtent: 50,
//             diameterRatio: 1.5,
//             squeeze: 2,
//             controller: FixedExtentScrollController(initialItem: 24),
//             physics: const FixedExtentScrollPhysics(),
//             onSelectedItemChanged: (value) {},
//             childDelegate: ListWheelChildBuilderDelegate(
//               childCount: measurements.length,
//               builder: (context, index) =>
//                   Text(style: TextStyle(fontSize: 24), '- ${measurements[index].toString()} -'),
//             ),
//           ),
//         ),
//         Align(
//           alignment: AlignmentGeometry.topCenter,
//           child: Text(
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             'D:',
//           ),
//         ),
//         SizedBox(
//           height: 100,
//           width: 50,
//           child: ListWheelScrollView.useDelegate(
//             changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
//             itemExtent: 50,
//             diameterRatio: 1.5,
//             squeeze: 2,
//             controller: FixedExtentScrollController(initialItem: 24),
//             physics: const FixedExtentScrollPhysics(),
//             onSelectedItemChanged: (value) {},
//             childDelegate: ListWheelChildBuilderDelegate(
//               childCount: measurements.length,
//               builder: (context, index) =>
//                   Text(style: TextStyle(fontSize: 24), '- ${measurements[index].toString()} -'),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
