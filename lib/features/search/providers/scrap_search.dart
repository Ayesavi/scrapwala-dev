import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/features/home/repositories/scrap_repository.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';

part 'scrap_search.freezed.dart';
part 'scrap_search.g.dart';
part 'scrap_search_state.dart';

@riverpod
class ScrapSearch extends _$ScrapSearch {
  final _scrapRepo = SupabaseScrapRepository();

  @override
  ScrapSearchState build() {
    return const _EmptySearch();
  }

  void search(String key) async {
    state = const ScrapSearchState.loading();
    final data = await _scrapRepo.searchScraps(key);
    if (key.isEmpty) {
      state = const ScrapSearchState.emptySearch();
    } else {
      state = ScrapSearchState.results(models: data);
    }
    return;
  }
}
