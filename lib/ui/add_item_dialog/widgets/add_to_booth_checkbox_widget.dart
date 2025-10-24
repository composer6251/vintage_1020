import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class AddToBoothCheckboxWidget extends HookConsumerWidget {
  const AddToBoothCheckboxWidget({
    super.key,
    required this.value,
    required this.onValueChanged,
    // required this.userBooths,
  });

  final bool value;
  final Function onValueChanged;
  // final List<String> userBooths;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // List<MyBooth> userBooths = ref.watch(myBoothsProvider);
    // void setMyBoothsProviders() async {

    //   if (ref.read(myBoothsProvider).isEmpty) {
    //     // await ref.read(myBoothsProvider.notifier).fetchUserBooths();
    //   }
    // }

    return Row(
      children: [
        Text(
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          addToBoothLabel,
        ),
        Checkbox(
          
          value: value,
          onChanged: (value) =>
            onValueChanged,
        ),
      ],
    );
  }
}
