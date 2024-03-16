import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pickup_request_model.freezed.dart';
part 'pickup_request_model.g.dart';

enum RequestStatus {
  picked,
  requested,
  denied,
  accepted,
  onTheWay,
  @Deprecated('Pending is deprecated and will be removed in future releases ')
  pending,
}

/// We can also reference it as a transaction model
@freezed
class PickupRequestModel with _$PickupRequestModel {
  factory PickupRequestModel({
    required String? addressId,
    required String id,
    required DateTime requestDateTime,
    required String requestingUserId,
    DateTime? scheduleDateTime,
    DateTime? pickedDateTime,
    ({String label, String address, String houseStreetNo})? address,
    required String qtyRange,
    @Default(RequestStatus.requested) RequestStatus status,

    // /// Maps scrap ids with their approx quantities
    // required Map<String, int> quantity,
  }) = _PickupRequestModel;

  factory PickupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PickupRequestModelFromJson(json);
}

extension RequestStatusExtension on RequestStatus {
  IconData get icon {
    switch (this) {
      case RequestStatus.picked:
        return Icons.done;
      case RequestStatus.requested:
        return Icons.pending;
      case RequestStatus.denied:
        return Icons.close;
      case RequestStatus.accepted:
        return Icons.check_circle;
      case RequestStatus.onTheWay:
        return Icons.directions_car;
      case RequestStatus.pending:
        return Icons.info; // For deprecated status
    }
  }

  IconData get outlinedIcon {
    switch (this) {
      case RequestStatus.picked:
        return Icons.done_outlined;
      case RequestStatus.requested:
        return Icons.pending_outlined;
      case RequestStatus.denied:
        return Icons.close_outlined;
      case RequestStatus.accepted:
        return Icons.check_circle_outlined;
      case RequestStatus.onTheWay:
        return Icons.directions_car_outlined;
      case RequestStatus.pending:
        return Icons.info_outlined; // For deprecated status
    }
  }

  Color getColor(BuildContext context) {
    switch (this) {
      case RequestStatus.picked:
        return const Color(0xff5ec792);
      case RequestStatus.requested:
        return Colors.orange;
      case RequestStatus.denied:
        return Theme.of(context).colorScheme.error;
      case RequestStatus.accepted:
        return const Color(0xff5ec792);
      case RequestStatus.onTheWay:
        return Theme.of(context).colorScheme.primary;
      case RequestStatus.pending:
        return Theme.of(context)
            .colorScheme
            .outline; // Default color for deprecated status
    }
  }
}
