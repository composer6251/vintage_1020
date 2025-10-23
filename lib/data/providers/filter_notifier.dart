

// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/constants/enums.dart';

part 'filter_notifier.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier{

  @override
  InventoryFilter build() {

    return InventoryFilter.all;
  }

  void setCurrentFilter(InventoryFilter filter) {
    state = filter;
  }

  void setCurrentTabInventoryFilter(int tabInd) {

    switch (tabInd) {
      case 1:
        state = InventoryFilter.listed;
      case 2:
        state = InventoryFilter.current;
      default:
        state = InventoryFilter.all;
    }
  }
}