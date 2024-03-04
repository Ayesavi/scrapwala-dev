part of 'scrap_search.dart';

@freezed
class ScrapSearchState with _$ScrapSearchState {
  const factory ScrapSearchState.loading() = _Loading;
  const factory ScrapSearchState.emptySearch() = _EmptySearch;
  const factory ScrapSearchState.results({required List<ScrapModel> models}) =
      _SearchWithResults;
}
