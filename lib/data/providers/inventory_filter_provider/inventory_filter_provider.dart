import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


enum InventoryFilter {
  all,
  myBooth,
  notListed,
  sold,
  furniture,
  archived,
  deleted,
  current,
}


enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class InventoryFilterProvider extends NotifierProvider<Map<Filter, bool>> {
  InventoryFilterProvider()
      : super({
          InventoryFilter.all: false,
          InventoryFilter.all: false,
          InventoryFilter.all: false,
          InventoryFilter.all: false,
          InventoryFilter.all: false,
          InventoryFilter.all: false,

        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    NotifierProvider<InventoryFilterProvider, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);