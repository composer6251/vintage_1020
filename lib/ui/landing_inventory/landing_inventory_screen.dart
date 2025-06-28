import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:vintage_1020/data/repositories/inventory_repo_server_cache.dart';
import 'package:vintage_1020/domain/models/mock/build_mock_models.dart';
import 'package:vintage_1020/providers/inventory_provider.dart';
import 'package:vintage_1020/ui/add_inventory_item/add_inventory_item_screen.dart';
import 'package:vintage_1020/ui/core/ui/shared/dialog/add_inventory_form_dialog.dart';
import 'package:vintage_1020/ui/edit_inventory_item/edit_inventory_item_screen.dart';
import 'package:vintage_1020/ui/inventory_carousel/inventory_carousel.dart';
import 'package:vintage_1020/ui/manage_inventory_screen/manage_inventory_screen.dart';
import 'package:vintage_1020/ui/manage_inventory_screen/manage_inventory_screen_stream.dart';

// class LandingInventoryScreen extends ConsumerWidget {
//   // @override
//   // State<LandingInventoryScreen> createState() => _LandingInventoryScreenState();
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

class LandingInventoryScreen extends ConsumerWidget {
  final logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    List<InventoryItem> models = [];

    models = BuildMockModels.buildInventoryItemModels();

    void openDialog() {
      showDialog(
        context: context,
        builder: (context) => const AddInventoryFormDialog(),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          HomeScreen(height: height, width: width, models: models),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: openDialog, backgroundColor: Colors.blue, child: Icon(Icons.add)),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.height,
    required this.width,
    required this.models,
  });

  final double height;
  final double width;
  final List<InventoryItem> models;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<InventoryItem> _filteredModels = [];
  List<InventoryItem> originalModels = [];
  List<InventoryItem> newModels = [];
  String _searchText = '';
  @override
  void initState() {
    var models = getInventoryItemStream();
    // models.cast<InventoryItem>().map((i) => {
    //   InventoryItem.fromJson(i.)
    // }).toList();

    var newModels = models.cast<InventoryItem>().toList;

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
                item.itemCategory.toString().toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.watch(inventoryNotifierProvider);
        return 
           ConstrainedBox(
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
                      Tab(text: 'Edit', icon: Icon(Icons.chair)),
                      // Tab(text: 'Add', icon: Icon(Icons.plus_one)),
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
                          models: _filteredModels,
                          height: widget.height / 2,
                          width: widget.width,
                          flexWeights: [1, 2, 1],
                        ),
                      ],
                    ),
                    // ManageInventoryScreenStream(),
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
                    EditInventoryItemScreen(),
                    // AddInventoryItemScreen(),
                  ],
                ),
            ),
          ),
        );
      },
    );
  }
}

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
                image.itemDescription ?? '',
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
