import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_large.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';
import 'package:scrapwala_dev/features/cart/providers/cart_controller.dart';
import 'package:scrapwala_dev/features/home/providers/home_page_controller.dart';
import 'package:scrapwala_dev/features/search/providers/scrap_search.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:scrapwala_dev/shared/cart_bottom_bar.dart';
import 'package:scrapwala_dev/shimmering_widgets/category_widget.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_scrap_tile.dart';
import 'package:scrapwala_dev/widgets/scrap_category_widget.dart';
import 'package:scrapwala_dev/widgets/scrap_tile.dart';
import 'package:scrapwala_dev/widgets/search_text_field.dart';
import 'package:uuid/uuid.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(scrapSearchProvider);
    final controller = ref.watch(scrapSearchProvider.notifier);
    final cartController = ref.read(cartControllerProvider.notifier);

    return Scaffold(
      bottomNavigationBar: const CartBottomBar(),
      appBar: AppBar(
        title: TitleLarge(
          text: 'Search',
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchTextField(
                  textController: textController,
                  triggerSearchOnChange: true,
                  onSearch: (searchKey) {
                    controller.search(searchKey);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 5,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
                const SizedBox(
                  height: 10,
                ),
                searchResults.when(
                    loading: () => const SizedBox(),
                    emptySearch: () => TitleMedium(
                          text: "Popular Categories",
                          color: Theme.of(context).colorScheme.onSurface,
                          weight: FontWeight.bold,
                        ),
                    results: (data) => TitleMedium(
                          text: "Search For ${textController.text}",
                          color: Theme.of(context).colorScheme.onSurface,
                        ))
              ],
            ),
          ),
          searchResults.when(loading: () {
            return Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: List.generate(
                  (10),
                  (index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: ShimmeringScrapTile(),
                  ),
                ),
              )),
            );
          }, emptySearch: () {
            return Builder(
              builder: (context) {
                final homePageState = ref.watch(homePageControllerProvider);

                return homePageState.when(networkError: (e) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        (6),
                        (index) => const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: ShimmeringCategoryWidget()),
                      ),
                    ),
                  );
                }, loading: () {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        (6),
                        (index) => const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: ShimmeringCategoryWidget()),
                      ),
                    ),
                  );
                }, data: (categories, scraps) {
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          (categories.length),
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: CategoryWidget(model: categories[index]),
                          ),
                        ),
                      ));
                }, error: (e) {
                  return const SizedBox();
                });
              },
            );
          }, results: (data) {
            return Expanded(
                child: data.isNotEmpty
                    ? ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx, index) {
                          return ScrapTile(
                            model: data[index],
                            isAdded: cartController.isCartContains(data[index]),
                            onAdd: () async {
                              await cartController.addCartItem(CartModel(
                                  id: const Uuid().v4(),
                                  qty: 1,
                                  scrap: data[index]));
                            },
                            onRemove: () async {
                              cartController
                                  .remooveItemFromCart(data[index].id);
                            },
                          );
                        })
                    : const Center(child: Text('No Results Found')));
          })
        ],
      ),
    );
  }
}
