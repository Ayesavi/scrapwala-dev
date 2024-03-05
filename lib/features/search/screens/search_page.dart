import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_large.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';
import 'package:scrapwala_dev/features/search/providers/scrap_search.dart';
import 'package:scrapwala_dev/models/scrap_category/scrap_category_model.dart';
import 'package:scrapwala_dev/sample/data/mock_categories.dart' as data;
import 'package:scrapwala_dev/widgets/scrap_category_widget.dart';
import 'package:scrapwala_dev/widgets/scrap_tile.dart';
import 'package:scrapwala_dev/widgets/search_text_field.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(scrapSearchProvider);
    final controller = ref.watch(scrapSearchProvider.notifier);
    return Scaffold(
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
            return const Center(child: CircularProgressIndicator());
          }, emptySearch: () {
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    (data.categories.length),
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: CategoryWidget(
                          model: ScrapCategoryModel.fromJson(
                              data.categories[index])),
                    ),
                  ),
                ));
          }, results: (data) {
            return Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
                      return ScrapTile(model: data[index], onTap: () {});
                    }));
          })
        ],
      ),
    );
  }
}
