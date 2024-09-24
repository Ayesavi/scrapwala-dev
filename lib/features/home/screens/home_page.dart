import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/cart/providers/cart_controller.dart';
import 'package:scrapwala_dev/features/home/providers/home_page_controller.dart';
import 'package:scrapwala_dev/features/home/screens/category_page.dart';
import 'package:scrapwala_dev/features/home/widgets/home_appbar_title.dart';
import 'package:scrapwala_dev/features/profile/providers/transaction_controller/transactions_conroller.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:scrapwala_dev/shared/cart_bottom_bar.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/shimmering_widgets/category_widget.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_scrap_tile.dart';
import 'package:scrapwala_dev/widgets/requess_status_combined_widget.dart';
import 'package:scrapwala_dev/widgets/scrap_category_widget.dart';
import 'package:scrapwala_dev/widgets/scrap_tile.dart';
import 'package:scrapwala_dev/widgets/search_text_field.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';
import 'package:uuid/uuid.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homePageControllerProvider);
    final controller = ref.read(homePageControllerProvider.notifier);
    final cartController = ref.read(cartControllerProvider.notifier);
    return Scaffold(
      bottomNavigationBar: const CartBottomBar(),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              controller.loadData();
              cartController.getCartItems();
              ref
                  .read(transactionsConrollerProvider.notifier)
                  .getTransactions();
            },
            child: CustomScrollView(slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: false,
                floating: true,
                title: const HomeAppBarTitle(),
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
                    state.when(networkError: (e) {
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
                    }, loading: () {
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
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return CategoryPage(
                                            id: categories[index].id,
                                            bannerUrl:
                                                categories[index].bannerUrl,
                                            title: categories[index].name);
                                      },
                                    ));
                                  },
                                )),
                      );
                    }, error: (e) {
                      return const Text("An error Occured");
                    }),
                    const SizedBox(height: 16)
                  ],
                ),
              ])),
              state.when(networkError: (e) {
                Future.delayed(const Duration(seconds: 1), () {
                  showSnackBar(
                      context, 'Looks like you are not connected to internet');
                });
                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return const ShimmeringScrapTile();
                  }, childCount: 6),
                );
              }, loading: () {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return const ShimmeringScrapTile();
                  }, childCount: 6),
                );
              }, data: (categories, scraps) {
                ref.watch(cartControllerProvider);
                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return ScrapTile(
                        isAdded: cartController.isCartContains(scraps[index]),
                        onAdd: () async {
                          try {
                            await cartController.addCartItem(CartModel(
                                id: const Uuid().v4(),
                                qty: 1,
                                scrap: scraps[index]));
                          } catch (e) {
                            if (context.mounted) {
                              showSnackBar(context, errorHandler(e).message);
                            }
                          }
                        },
                        onRemove: () async {
                          await cartController
                              .remooveItemFromCart(scraps[index].id);
                        },
                        model: scraps[index]);
                  }, childCount: scraps.length),
                );
              }, error: (e) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("An Error Occurred"),
                  ),
                );
              })
            ]),
          ),
        ],
      ),
    );
  }
}
