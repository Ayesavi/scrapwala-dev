import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  factory TransactionModel({
    required String transactionId,
    required String requestId,
    required AddressModel pickupLocation,
    required DateTime pickupTime,
    required List<OrderQuantity> orders,
    String? photograph,
    required int totalAmountPaid,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

@freezed
abstract class OrderQuantity with _$OrderQuantity {
  factory OrderQuantity({
    required String id,
    required String name,
    required ScrapMeasurement measurement,
    required int quantity,
    required int price,
  }) = _OrderQuantity;

  factory OrderQuantity.fromJson(Map<String, dynamic> json) =>
      _$OrderQuantityFromJson(json);
}
