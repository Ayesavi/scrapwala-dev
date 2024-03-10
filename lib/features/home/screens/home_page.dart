import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/providers/location_provider/location_controller.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/home/providers/home_page_controller.dart';
import 'package:scrapwala_dev/shimmering_widgets/category_widget.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_scrap_tile.dart';
import 'package:scrapwala_dev/widgets/added_item_widget.dart';
import 'package:scrapwala_dev/widgets/location_bottomsheet.dart';
import 'package:scrapwala_dev/widgets/location_tile_open_bottomsheet.dart';
import 'package:scrapwala_dev/widgets/scrap_category_widget.dart';
import 'package:scrapwala_dev/widgets/scrap_tile.dart';
import 'package:scrapwala_dev/widgets/search_text_field.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationControllerProvider);
    final locationController = ref.read(locationControllerProvider.notifier);
    final state = ref.watch(homePageControllerProvider);
    final controller = ref.read(homePageControllerProvider.notifier);

    return Scaffold(
      bottomNavigationBar: const AddedItemCartWidget(
        itemAdded: 2,
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
               controller.loadData();
            },
            child: CustomScrollView(slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: false,
                floating: true,
                title: locationState.when(
                  locationNotSet: () {
                    return const LocationTileOpenBottomsheet(model: null);
                  },
                  empty: () {
                    return const TitleLarge(
                      text: "ScrapWala Dev",
                      weight: FontWeight.bold,
                    );
                  },
                  location: (model) {
                    return LocationTileOpenBottomsheet(
                      model: model,
                      onTap: () {
                        showBottomLocationSheet(context, isDismissable: false,
                            onTapAddress: (m) {
                          locationController.setLocation(m);
                          Navigator.pop(context);
                        },
                            isLocationPermissionGranted: false,
                            addresses: locationController.address);
                      },
                    );
                  },
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight + 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: SearchTextField(
                      readOnly: true,
                      onPressed: () {
                        const SearchPageRoute().go(context);
                      },
                    ),
                  ),
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
              SliverToBoxAdapter(
                  child: Column(children: [
                const SizedBox(
                  height: 16,
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
                    state.when(loading: () {
                      return SizedBox(
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
                            itemCount: 12,
                            itemBuilder: (context, index) =>
                                const ShimmeringCategoryWidget()),
                      );
                    }, data: (categories, scraps) {
                      return SizedBox(
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
                            itemCount: categories.length,
                            itemBuilder: (context, index) => CategoryWidget(
                                  model: categories[index],
                                )),
                      );
                    }, error: (e) {
                      return const Text("An error Occured");
                    }),
                    const SizedBox(height: 16)
                  ],
                ),
              ])),
              state.when(loading: () {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return const ShimmeringScrapTile();
                  }, childCount: 6),
                );
              }, data: (categories, scraps) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return ScrapTile(onTap: () {}, model: scraps[index]);
                  }, childCount: scraps.length),
                );
              }, error: (e) {
                return const Text("An Error Occurred");
              })
            ]),
          ),
        ],
      ),
    );
  }
}
