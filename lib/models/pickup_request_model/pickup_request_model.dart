import 'package:freezed_annotation/freezed_annotation.dart';

part 'pickup_request_model.freezed.dart';
part 'pickup_request_model.g.dart';

enum RequestStatus {
  picked,
  pending,
  denied,
}

/// We can also reference it as a transaction model
@freezed
class PickupRequestModel with _$PickupRequestModel {
  factory PickupRequestModel({
    required String addressId,
    required String id,
    required DateTime requestDateTime,
    required String requestingUserId,
    DateTime? scheduleDateTime,
    DateTime? pickedDateTime,
    required String qtyRange,
    @Default(RequestStatus.pending) RequestStatus status,

    // /// Maps scrap ids with their approx quantities
    // required Map<String, int> quantity,
  }) = _PickupRequestModel;

  factory PickupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PickupRequestModelFromJson(json);
}
