import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/features/home/repositories/category_repository.dart';
import 'package:scrapwala_dev/features/home/repositories/scrap_repository.dart';
import 'package:scrapwala_dev/models/scrap_category/scrap_category_model.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';

part 'home_page_controller.freezed.dart';
part 'home_page_controller.g.dart';
part 'home_page_controller_state.dart';

@riverpod
class HomePageController extends _$HomePageController {
  final _categoryRepo = SupabaseCategoryRepository();
  final _scrapRepo = SupabaseScrapRepository();

  @override
  HomePageControllerState build() {
    loadData();
    return const _Initial();
  }

  void loadData() async {
    try {
      final categories = await _categoryRepo.getCategories();
      final scraps = await _scrapRepo.getScraps();
      state = _Data(scraps: scraps, categories: categories);
    } catch (e) {
      if (e is NetworkException) {
        state = _NetworkError(e);
      } else {
        state = _Error(e);
      }
    }
  }
}
