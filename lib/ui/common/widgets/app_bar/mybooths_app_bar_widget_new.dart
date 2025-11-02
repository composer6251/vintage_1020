import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/constants/booth_discounts.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/common/dropdowns/drop_down_from_map.dart';
import 'package:vintage_1020/ui/common/dropdowns/select_booth_dropdown_widget.dart';
import 'package:vintage_1020/ui/common/widgets/menu_select/three_dots_menu_select_widget.dart';
import 'package:vintage_1020/util/photo_util.dart';

class MyBoothsAppBarNew extends HookConsumerWidget {
  @override
  AppBar build(BuildContext context, WidgetRef ref) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final userBooths = ref.watch(myBoothsProvider);
    final currentBooth = ref.watch(currentBoothProvider);
    final selectedDiscount = useState<int?>(0);

    void takeBoothPhoto() async {
      String boothPhotoPath = await PhotoUtil.takePhotoAndReturnUrl();
      List<String>? selectedBoothImageUrlsCurrentState =
          currentBooth.currentBoothImageUrls;

      selectedBoothImageUrlsCurrentState.add(boothPhotoPath);

      MyBooth booth = currentBooth;
      booth.currentBoothImageUrls = selectedBoothImageUrlsCurrentState;

      await ref.read(myBoothsProvider.notifier).updateBooth(booth);
    }

    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.blue,
      toolbarHeight: MediaQuery.sizeOf(context).height * .30,
      actions: [
        Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: ThreeDotsMenuSelectWidget(),
              // child: DropDownFromMap(
              //   key: key,
              //   keyValueMap: boothDiscounts,
              //   onValueUpdated: (value) =>
              //       selectedDiscount.value = int.tryParse(value),
              // ),
            ),
            Flexible(
              flex: 1,
              child: SelectBoothDropDown(userBooths: userBooths)),
            Flexible(
              flex: 1,
              child: IconButton(
                onPressed: takeBoothPhoto,
                icon: FaIcon(FontAwesomeIcons.camera),
                iconSize: 32,
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(onPressed: auth.signOut, icon: Icon(Icons.logout_outlined))),
              ],
            ),
        ],
    );
  }
}
