import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/providers/inventory_provider/inventory_provider.dart';

class ActivityGraph extends HookConsumerWidget {
  const ActivityGraph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final items = ref.watch(inventoryNotifierProvider);
    // String getDateKey
    final soldItems = useMemoized(() {
      for (var item in items) {
        if (item.itemPurchaseDate == null) {}
      }
    }, [items]);

    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(),
      child: Row(
        children: List.generate(items.length, (index) {
          const opacity = .2;
          return Expanded(
            child: Tooltip(
              message: 'test message',
              child: Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(),
              ),
            ),
          );
        }),
      ),
    );
  }
}
