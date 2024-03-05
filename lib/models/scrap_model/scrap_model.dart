import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrap_model.freezed.dart';
part 'scrap_model.g.dart';

@freezed
abstract class ScrapModel with _$ScrapModel {
  const factory ScrapModel({
    required String name,
    String? photoUrl,
    required String description,
    required double price,
    @Default(false) bool isNegotiable,
  }) = _ScrapModel;

  factory ScrapModel.fromJson(Map<String, dynamic> json) =>
      _$ScrapModelFromJson(json);
}
