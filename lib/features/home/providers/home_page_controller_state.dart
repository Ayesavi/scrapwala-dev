part of 'home_page_controller.dart';

@freezed
class HomePageControllerState with _$HomePageControllerState {
  const factory HomePageControllerState.loading() = _Initial;
  const factory HomePageControllerState.data({
    required List<ScrapCategoryModel> categories,
    required List<ScrapModel> scraps,
  }) = _Data;
  const factory HomePageControllerState.networkError(Object e) = _NetworkError;

  const factory HomePageControllerState.error(Object e) = _Error;
}
