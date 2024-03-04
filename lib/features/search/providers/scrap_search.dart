import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';

part 'scrap_search.freezed.dart';
part 'scrap_search.g.dart';
part 'scrap_search_state.dart';

@riverpod
class ScrapSearch extends _$ScrapSearch {
  @override
  ScrapSearchState build() {
    return const _EmptySearch();
  }

  void search(String key) async {
    state = const ScrapSearchState.loading();
    final data = await Future.delayed(const Duration(seconds: 1), () {
      return [
        const ScrapModel(
            description:
                "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
            price: 23,
            photoUrl: 'https://picsum.photos/100/100?random=9',
            name: "Glossy Papers"),
        const ScrapModel(
            description:
                "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
            price: 23,
            photoUrl: 'https://picsum.photos/100/100?random=9',
            name: "Glossy Papers")
      ];
    });
    if (key.isEmpty) {
      state = const ScrapSearchState.emptySearch();
    } else {
      state = ScrapSearchState.results(models: data);
    }
    return;
  }
}
