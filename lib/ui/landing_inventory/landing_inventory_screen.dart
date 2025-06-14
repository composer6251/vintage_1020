import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:namer_app/domain/models/mock/build_mock_models.dart';
import 'package:namer_app/picture_names.dart';
import 'package:namer_app/ui/core/ui/widgets/inputform_vertical.dart';
import 'package:namer_app/ui/edit_inventory_item/edit_inventory_item_screen.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel_viewmodel.dart';
import 'package:namer_app/ui/manage_inventory_screen/manage_inventory_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingInventoryScreen extends StatefulWidget {
  @override
  State<LandingInventoryScreen> createState() => _LandingInventoryScreenState();
}

class _LandingInventoryScreenState extends State<LandingInventoryScreen> {
  final logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    List<InventoryItem> models = [];

    models = BuildMockModels.buildInventoryItemModels();

    return Column(
      children: [
        ConstrainedAppBarTabs(height: height, width: width, models: models),
      ],
    );
  }
}

class ConstrainedAppBarTabs extends StatefulWidget {
  const ConstrainedAppBarTabs({
    super.key,
    required this.height,
    required this.width,
    required this.models,
  });

  final double height;
  final double width;
  final List<InventoryItem> models;

  @override
  State<ConstrainedAppBarTabs> createState() => _ConstrainedAppBarTabsState();
}

class _ConstrainedAppBarTabsState extends State<ConstrainedAppBarTabs> {
  List<InventoryItem> _filteredModels = [];
  List<InventoryItem> originalModels = [];
  String _searchText = '';
  @override
  void initState() {
    setState(() {
      _filteredModels = widget.models;
    });
  }

  void _filterResults(String query) {
    setState(() {
      _searchText = query;
      if (_searchText == '') {
        _filteredModels = widget.models;
        return;
      }
      //originalModels = widget.models;
      _filteredModels = widget.models
          .where(
            (item) =>
                item.itemCategory.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.height,
        maxWidth: widget.width,
      ),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 50, 50, 235),
            bottom: TabBar(
              unselectedLabelColor: const Color.fromARGB(255, 87, 3, 3),
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Inventory', icon: Icon(Icons.favorite)),
                Tab(text: 'Manage', icon: Icon(Icons.chair_rounded)),
                Tab(text: 'Add', icon: Icon(Icons.plus_one)),
                Tab(text: 'Edit', icon: Icon(Icons.chair)),
              ],
            ),
          ),
          body: TabBarView(
            // controller: TabController(length: 0, vsync: ),
            children: [
              Column(
                children: [
                  SearchBar(
                    onChanged: (String value) => _filterResults(value),
                    leading: const Icon(Icons.search),
                    hintText: 'Search',
                  ),
                  InventoryCarousel(
                    images: _filteredModels,
                    height: widget.height / 2,
                    width: widget.width,
                    flexWeights: [1, 2, 1],
                  ),
                ],
              ),
              Column(
                children: [
                  SearchBar(
                    onChanged: (String value) => _filterResults(value),
                    leading: const Icon(Icons.search),
                    hintText: 'Search',
                  ),
                  Expanded(
                    flex: 4,
                    child: ListView.separated(
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ManageInventoryScreen(
                          model: _filteredModels[index],
                          width: widget.width / 2,
                          height: widget.height / 4.25,
                        );
                      },
                      separatorBuilder: (_, _) => Divider(),
                      itemCount: _filteredModels.length,
                    ),
                  ),
                ],
              ),
              AddInventoryItem(),
              EditInventoryItemScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddInventoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InputFormVertical(title: 'Add To Inventory', isHorizontal: false);
  }
}

// class InventoryCarousel extends StatelessWidget {
//   const InventoryCarousel({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.models,
//   });

//   final double height;
//   final double width;
//   final List<InventoryItem> models;

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(maxHeight: height / 3),
//       child: CarouselView.weighted(
//         // controller: controller,
//         itemSnapping: true,
//         flexWeights: const <int>[1, 2, 7],
//         children: models.map((image) {
//           return HeroLayoutCard(image: image);
//         }).toList(),
//       ),
//     );
//   }
// }

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.image});

  final InventoryItem image;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 7 / 8,
            minWidth: width * 6 / 8,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(
                image.itemImageUrls.first,
              ), // TODO: make the actual defaultImageUrl
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '\$${image.itemListingPrice}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              ),
              Text(
                'Category: ${image.itemCategory}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              ),
              Text(
                image.itemDescription,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              ),
              const SizedBox(height: 10),
              Text(
                'Listed: ${image.itemListingDate.toString()}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class InventoryWidget extends StatelessWidget {
//   const InventoryWidget({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.models,
//   });

//   final double height;
//   final double width;
//   final List<InventoryItem> models;

//   @override
//   Column build(context) {
//     return Column(
//       children: [
//         SearchBar(leading: const Icon(Icons.search), hintText: 'Search'),
//         ConstrainedBox(
//           constraints: const BoxConstraints(maxHeight: 100),
//           child: CarouselView.weighted(
//             flexWeights: const <int>[1, 2, 3, 2, 1],
//             consumeMaxWeight: true,
//             // TODO ADD ON TAP
//             onTap: (value) => {
//               Navigator.pushNamed(context, '/manage-inventory'),
//             },
//             children: models.map((image) {
//               return Image.asset(image.itemImageUrls.first);
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// List<InventoryItem> buildInventoryCarouselViewModels() {
//   List<String> modelList = PictureNames.picListFurniture;
//   List<InventoryItem> models = [];
//   List<String> categories = ['Furniture', 'Lamp', 'Painting', 'Wall decor'];

//   for (var m in modelList) {
//     List<String> imageUrls = [m];
//     int cat = Random().nextInt(categories.length);
//     InventoryItem model = InventoryItem(
//       itemImageUrls: imageUrls,
//       itemPurchaseDate: DateTime.now(),
//       itemPurchasePrice: 100.0,
//       itemDescription: "itemDescription",
//       itemListingDate: DateTime.now(),
//       itemListingPrice: 100.0,
//       itemCategory: categories[cat],
//     );

//     models.add(model);
//   }

//   return models;
// }
