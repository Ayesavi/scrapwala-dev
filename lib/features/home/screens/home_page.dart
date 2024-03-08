import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/models/scrap_category/scrap_category_model.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:scrapwala_dev/widgets/added_item_widget.dart';
import 'package:scrapwala_dev/widgets/location_bottomsheet.dart';
import 'package:scrapwala_dev/widgets/location_tile_open_bottomsheet.dart';
import 'package:scrapwala_dev/widgets/scrap_category_widget.dart';
import 'package:scrapwala_dev/widgets/scrap_tile.dart';
import 'package:scrapwala_dev/widgets/search_text_field.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  // Sample data for category models
  final categoryData = [
    {"name": "Category 1", "photoUrl": "https://picsum.photos/80/80?random=1"},
    {"name": "Category 2", "photoUrl": "https://picsum.photos/80/80?random=2"},
    {"name": "Category 3", "photoUrl": "https://picsum.photos/80/80?random=3"},
    {"name": "Category 4", "photoUrl": "https://picsum.photos/80/80?random=4"},
    {"name": "Category 5", "photoUrl": "https://picsum.photos/80/80?random=5"},
    {"name": "Category 6", "photoUrl": "https://picsum.photos/80/80?random=6"},
    {"name": "Category 7", "photoUrl": "https://picsum.photos/80/80?random=7"},
    {"name": "Category 8", "photoUrl": "https://picsum.photos/80/80?random=8"},
    {"name": "Category 9", "photoUrl": "https://picsum.photos/80/80?random=9"},
    {
      "name": "Category 10",
      "photoUrl": "https://picsum.photos/80/80?random=10"
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = ref.watch(authControllerProvider);

    return Scaffold(
      bottomNavigationBar: const AddedItemCartWidget(
        itemAdded: 2,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: LocationTileOpenBottomsheet(
          model: AddressModel(
              houseStreetNo: '57',
              address: "Devpuri, House number 44 Wallfort Paradise",
              latlng: (lat: 2432432.42342, lng: 213421423),
              createdAt: DateTime.now(),
              id: 'id',
              category: AddressCategory.house,
              label: "Wallfort Paradise"),
          onTap: () {
            showBottomLocationSheet(context,
                isDismissable: false,
                isLocationPermissionGranted: false,
                addresses: []);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.outline.withOpacity(.3),
              child: IconButton(
                  onPressed: () async {
                    const ProfilePageRoute().go(context);
                    // await ref.read(authControllerProvider).signOut();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchTextField(
                        readOnly: true,
                        onPressed: () {
                          const SearchPageRoute().go(context);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: LabelLarge(
                            text: "What's on your mind?".toUpperCase(),
                            spacing: 3,
                            weight: FontWeight.w100,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Theme.of(context).colorScheme.outline,
                                  Colors.transparent
                                ],
                              ).createShader(bounds);
                            },
                            child: Divider(
                              thickness: 1,
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline, // Set the color to transparent
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 240,
                      child: GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                2, // You can change this value according to your requirement
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: categoryData.length,
                          itemBuilder: (context, index) => CategoryWidget(
                                model: ScrapCategoryModel.fromJson(
                                    categoryData[index]),
                              )),
                    ),
                  ],
                ),
                ScrapTile(
                    added: true,
                    onTap: () {},
                    model: const ScrapModel(
                        description:
                            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
                        price: 23,
                        photoUrl: 'https://picsum.photos/100/100?random=9',
                        name: "Glossy Papers")),
                ScrapTile(
                    onTap: () {},
                    model: const ScrapModel(
                        description:
                            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
                        price: 23,
                        photoUrl: "https://picsum.photos/80/80?random=10",
                        name: "Glossy Papers"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
