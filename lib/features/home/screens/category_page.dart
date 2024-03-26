import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/cart/providers/cart_controller.dart';
import 'package:scrapwala_dev/features/home/repositories/category_repository.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:scrapwala_dev/shared/cart_bottom_bar.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_scrap_tile.dart';
import 'package:scrapwala_dev/widgets/scrap_tile.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';
import 'package:uuid/uuid.dart';

part 'category_page.g.dart';

@riverpod
Future<List<ScrapModel>> getScraps(GetScrapsRef ref, String id) async {
  return SupabaseCategoryRepository().getScraps(id);
}

class CategoryPage extends ConsumerWidget {
  final String id;
  final String title;
  final String? bannerUrl;

  CategoryPage(
      {super.key, this.bannerUrl, required this.id, required this.title}) {
    FirebaseAnalytics.instance.logScreenView(
      screenName: title,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getScrapsProvider(id));
    return Scaffold(
        bottomNavigationBar: const CartBottomBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(getScrapsProvider);
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 100,
                floating: false,
                pinned: true,

                actions: [
                  IconButton(
                      onPressed: () {
                        SearchPageRoute(categoryId: id).push(context);
                      },
                      icon: const Icon(Icons.search, size: 25))
                ],
                // title: TitleLarge(text: title),
                flexibleSpace: FlexibleSpaceBar(
                  title: TitleLarge(text: title),
                  background: bannerUrl.isNotNull
                      ? Image.network(
                          bannerUrl!,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              state.when(data: (data) {
                final cartController =
                    ref.read(cartControllerProvider.notifier);

                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return ScrapTile(
                        isAdded: cartController.isCartContains(data[index]),
                        onAdd: () async {
                          try {
                            await cartController.addCartItem(CartModel(
                                id: const Uuid().v4(),
                                qty: 1,
                                scrap: data[index]));
                          } catch (e) {
                            if (context.mounted) {
                              showSnackBar(context, errorHandler(e).message);
                            }
                          }
                        },
                        onRemove: () async {
                          await cartController
                              .remooveItemFromCart(data[index].id);
                        },
                        model: data[index]);
                  }, childCount: data.length),
                );
              }, error: (e, s) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return const ShimmeringScrapTile();
                  }, childCount: 12),
                );
              }, loading: () {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return const ShimmeringScrapTile();
                  }, childCount: 12),
                );
              })
            ],
          ),
        ));
  }
}
