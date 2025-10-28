import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class SelectBoothWidget extends HookConsumerWidget {
  SelectBoothWidget({
    required super.key,
    required this.currentBooths,
    required this.onBoothChanged,
  });

  late final List<MyBooth> currentBooths;
  final GestureTapCallback onBoothChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void updateCurrentBooth(MyBooth booth) {
      ref.read(currentBoothProvider.notifier).setCurrentBooth(booth);
    }

    return ListView.builder(
      itemExtent: 150,
      scrollDirection: Axis.horizontal,
      itemCount: currentBooths.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: GestureDetector(
            onTap: () {
              print('Gesture');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Badge(
                  label: Text(currentBooths[index].boothItemsCount.toString()),
                  child: FaIcon(FontAwesomeIcons.tent),
                ),
                Text(currentBooths[index].boothName),
              ],
            ),
          ),
        );
      },
    );
  }
}
