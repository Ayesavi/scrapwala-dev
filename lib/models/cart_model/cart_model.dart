import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
abstract class CartModel with _$CartModel {
  const factory CartModel({
    required String id,
    required ScrapModel scrap,
    required int qty,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}
