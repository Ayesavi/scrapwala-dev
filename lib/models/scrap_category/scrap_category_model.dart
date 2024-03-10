import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrap_category_model.freezed.dart';
part 'scrap_category_model.g.dart';

@freezed
abstract class ScrapCategoryModel with _$ScrapCategoryModel {
  const factory ScrapCategoryModel({
    required String name,
    required String id,
    required String photoUrl,
  }) = _ScrapCategory;

  factory ScrapCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ScrapCategoryModelFromJson(json);
}
