import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/constants/enums.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_counts_notifier/inventory_counts_notifier.dart';

class FilterSegmentedButton extends HookConsumerWidget {
  FilterSegmentedButton({required super.key});

  final InventoryFilter currentFilter = InventoryFilter.all;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch inventory counts
    final inventoryCounts = ref.watch(inventoryCountsProvider);
    final currentFilter = ref.watch(filterProvider);

    void setNewInventoryFilter(InventoryFilter newFilter) {
      ref.read(filterProvider.notifier).setCurrentFilter(newFilter);
    }

    return SegmentedButton<InventoryFilter>(
      style: ButtonStyle(elevation: WidgetStatePropertyAll(300)),
      multiSelectionEnabled: false,
      selected: {currentFilter},
      onSelectionChanged: (Set<InventoryFilter> filters) {
        setNewInventoryFilter(filters.first);
      },
      segments: <ButtonSegment<InventoryFilter>>[
        ButtonSegment<InventoryFilter>(
          enabled: true,
          value: InventoryFilter.all,
          label: Text(style: TextStyle(fontSize: 20), 'All'),
        ),
        ButtonSegment<InventoryFilter>(
          value: InventoryFilter.listed,
          label: Text(style: TextStyle(fontSize: 20), 'Listed'),
        ),
        ButtonSegment<InventoryFilter>(
          value: InventoryFilter.backStock,
          label: Text(style: TextStyle(fontSize: 20), 'Backstock'),
        ),
        // ButtonSegment<InventoryFilter>(
        //   value: InventoryFilter.sold,
        //   label: Badge(
        //     label: Text(inventoryCounts[InventoryFilter.sold.name].toString()),
        //     child: Text(style: TextStyle(fontSize: 24), 'Sold'),
        //   ),
        // ),
      ],
    );
  }
}
