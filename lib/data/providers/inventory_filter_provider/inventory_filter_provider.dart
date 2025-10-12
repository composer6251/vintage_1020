// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
// import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

// part 'inventory_filter_provider.g.dart';

// enum InventoryFilter {
//   all,
//   myBooth,
//   listed,
//   sold,
//   furniture,
//   backStock,
//   deleted,
//   current,
// }

// // NOTIFIER PROVIDER TO HOLD CURRENT FILTER AND UPDATE AS NEEDED
// @riverpod
// class InventoryFilterNotifier extends _$InventoryFilterNotifier {

//   @override
//   Map<InventoryFilter, bool> build() {
//     // Set initial value
//     return {InventoryFilter.all: true};
//   }
//   // InventoryFilterNotifier()
//   //     : super({
//   //         InventoryFilter.all: false,
//   //         InventoryFilter.all: false, 
//   //         InventoryFilter.all: false,
//   //         InventoryFilter.all: false,
//   //         InventoryFilter.all: false,
//   //         InventoryFilter.all: false,

//   //       });


//   void setFilters(Map<InventoryFilter, bool> chosenFilters) {
//     state = chosenFilters;
//   }

//   void setFilter(InventoryFilter filter, bool isActive) {
//     // state[filter] = isActive; // not allowed! => mutating state
//     state = {
//       ...state,
//       filter: isActive,
//     };
//   }
// }

// // NotifierProvider is an interface which takes the types: 1. The Notifier created(InventoryFilterNotifier) and the return type 

// // 1. Create class for Notifier(InventoryFilterNotifier above)
// // 2. Initialize NotifierProvider, declaring type of 1. InventoryFilterNotifier, and 2. Return value
// // final filtersProvider =
// //     NotifierProvider<InventoryFilterNotifier, Map<InventoryFilter, bool>>(() {
      

// //       return InventoryFilterNotifier();
// //     }
// // );

// // final inventoryFilter = NotifierProvider<InventoryFilterNotifier, Map<InventoryFilter, bool>>(() {
// //   final List<InventoryItemLocal> inventory = ref.watch(inventoryLocalProvider);
// //   final filter = ref.watch(filteredInventoryProvider);
// //   // final id = ref.watch(currentInventoryItemProvider.notifier);

// //   switch (filter) {
// //     case InventoryFilter.myBooth:
// //       print('Filter BOOTH');
// //       List<InventoryItemLocal> inventoryByFlag = inventory
// //           .where((item) => item.isCurrentBoothItem == 1.0)
// //           .toList();
// //       print('inventory by flag $inventoryByFlag');
// //       return inventory
// //           .where(
// //             (item) => item.itemListingDate != null && item.itemSoldDate == null,
// //           )
// //           .toList();
// //     case InventoryFilter.notListed:
// //       print('Filter NOT LISTED');
// //       return inventory.where((item) => item.itemListingDate != null).toList();
// //     case InventoryFilter.sold:
// //       print('Filter SOLD');
// //       return inventory.where((item) => item.itemSoldDate != null).toList();
// //     case InventoryFilter.furniture:
// //       print('Filter FURNITURE');
// //       return inventory
// //           .where((item) => item.itemCategory == 'Furniture')
// //           .toList();
// //     // TODO: IMPLEMENT
// //     case InventoryFilter.archived:
// //       return inventory;
// //     // TODO: IMPLEMENT
// //     case InventoryFilter.deleted:
// //       print('Filter DELETED');
// //       return inventory.where((item) => item.itemSoldDate != null).toList();
// //     case InventoryFilter.current:
// //       return inventory; //.where((item) => item.id == id).toList();
// //     case InventoryFilter.all:
// //       return inventory;
// //   }
// // });