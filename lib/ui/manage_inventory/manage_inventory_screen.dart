import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:namer_app/picture_names.dart';
import 'package:namer_app/ui/core/ui/widgets/inputform.dart';
import 'package:namer_app/ui/edit_inventory_item/edit_inventory_item_screen.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel_viewmodel.dart';

class ManageInventoryScreen extends StatelessWidget {
  final logger = Logger(printer: PrettyPrinter());
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    List<InventoryItem> models = [];
    models = buildInventoryCarouselViewModels();

    return Column(
      children: [
        ConstrainedAppBarTabs(height: height, width: width, models: models),
      ],
    );
  }
}

class ConstrainedAppBarTabs extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height, maxWidth: width),
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
                  SearchBar(leading: const Icon(Icons.search), hintText: 'Search'),
                  InventoryCarousel(
                    height: height,
                    width: width,
                    models: models,
                  ),
                ],
              ),
              Column(
                children: [
                  SearchBar(leading: const Icon(Icons.search), hintText: 'Search'),
                  Expanded(
                    flex: 4,
                    child: ListView.separated(
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SingleInventoryItem(
                          model: models[index],
                          width: width / 2,
                          height: height / 4,
                        );
                      },
                      separatorBuilder: (_, _) => Divider(),
                      itemCount: models.length,
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
            // RichText(
            //   text: TextSpan(
            //       style: TextStyle(
            //       fontSize: 12.0, 
            //       fontWeight: FontWeight.bold),
            //       children: <TextSpan>[
            //       TextSpan(text: 'Item:', style: TextStyle(fontWeight: FontWeight.bold)),
            //       TextSpan(text: model.itemPrice, style: TextStyle(fontStyle: FontStyle.italic))
            //     ],
            //     ),
                

class AddInventoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InputForm(title: 'Add To Inventory', isHorizontal: false,);
  }
}

class SingleInventoryItem extends StatelessWidget {
  const SingleInventoryItem({
    super.key,
    required this.model,
    required this.width,
    required this.height,
  });

  final InventoryItem model;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Image.asset(
            fit: BoxFit.fill,
          //  alignment: AlignmentGeometry.xy(0, 0),
            // height: height * .20,
            // width: width * .10,
            model.itemImageUrl,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Item: ${model.itemDescription}'),
            Text('Date Listed price: ${model.itemPrice}'),
            Text('Listing price: ${model.itemPrice}'),
          ],
        ),
         Flexible(
          fit: FlexFit.tight,
          child: Banner(
            location: BannerLocation.bottomStart,
            // layoutDirection: textDirectionToAxisDirection(TextDirection.LTR),
            color: const Color.fromARGB(255, 13, 94, 16),
            message: 'SOLD',
          ),
        ),
        Flexible(
          // flex: 5,
          // fit: FlexFit.loose,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.delete))),
       
      ],
    );
  }
}

class InventoryCarousel extends StatelessWidget {
  const InventoryCarousel({
    super.key,
    required this.height,
    required this.width,
    required this.models,
  });

  final double height;
  final double width;
  final List<InventoryItem> models;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height / 3),
      child: CarouselView.weighted(
        // controller: controller,
        itemSnapping: true,
        flexWeights: const <int>[1, 2, 7],
        children: models.map((image) {
          return HeroLayoutCard(image: image);
        }).toList(),
      ),
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
              image: AssetImage(image.itemImageUrl),
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
                '\$${image.itemPrice}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              Text(
                image.itemDescription,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'Listed: ${image.itemListingDate.toString()}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InventoryWidget extends StatelessWidget {
  const InventoryWidget({
    super.key,
    required this.height,
    required this.width,
    required this.models,
  });

  final double height;
  final double width;
  final List<InventoryItem> models;

  @override
  Column build(context) {
    return Column(
      children: [
        SearchBar(leading: const Icon(Icons.search), hintText: 'Search'),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 100),
          child: CarouselView.weighted(
            flexWeights: const <int>[1, 2, 3, 2, 1],
            consumeMaxWeight: true,
            // TODO ADD ON TAP
            onTap: (value) => {
              Navigator.pushNamed(context, '/manage-inventory'),
            },
            children: models.map((image) {
              return Image.asset(image.itemImageUrl);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

List<InventoryItem> buildInventoryCarouselViewModels() {
  List<String> imageList = PictureNames.picListFurniture;
  List<InventoryItem> models = [];
  for (var image in imageList) {
    InventoryItem model = InventoryItem(
      itemImageUrl: image,
      itemDescription: "itemDescription",
      itemListingDate: DateFormat.yMEd().add_jms().format(DateTime.now()),
      itemPrice: "100.0",
    );

    models.add(model);
  }

  return models;
}
