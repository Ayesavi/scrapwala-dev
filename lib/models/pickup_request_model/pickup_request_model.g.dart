// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PickupRequestModelImpl _$$PickupRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PickupRequestModelImpl(
      addressId: json['addressId'] as String?,
      id: json['id'] as String,
      requestDateTime: DateTime.parse(json['requestDateTime'] as String),
      requestingUserId: json['requestingUserId'] as String,
      scheduleDateTime: json['scheduleDateTime'] == null
          ? null
          : DateTime.parse(json['scheduleDateTime'] as String),
      pickedDateTime: json['pickedDateTime'] == null
          ? null
          : DateTime.parse(json['pickedDateTime'] as String),
      address: _$recordConvertNullable(
        json['address'],
        ($jsonValue) => (
          address: $jsonValue['address'] as String,
          houseStreetNo: $jsonValue['houseStreetNo'] as String,
          label: $jsonValue['label'] as String,
        ),
      ),
      qtyRange: json['qtyRange'] as String,
      status: $enumDecodeNullable(_$RequestStatusEnumMap, json['status']) ??
          RequestStatus.requested,
    );

Map<String, dynamic> _$$PickupRequestModelImplToJson(
        _$PickupRequestModelImpl instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'id': instance.id,
      'requestDateTime': instance.requestDateTime.toIso8601String(),
      'requestingUserId': instance.requestingUserId,
      'scheduleDateTime': instance.scheduleDateTime?.toIso8601String(),
      'pickedDateTime': instance.pickedDateTime?.toIso8601String(),
      'address': instance.address == null
          ? null
          : {
              'address': instance.address!.address,
              'houseStreetNo': instance.address!.houseStreetNo,
              'label': instance.address!.label,
            },
      'qtyRange': instance.qtyRange,
      'status': _$RequestStatusEnumMap[instance.status]!,
    };

$Rec? _$recordConvertNullable<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    value == null ? null : convert(value as Map<String, dynamic>);

const _$RequestStatusEnumMap = {
  RequestStatus.picked: 'picked',
  RequestStatus.requested: 'requested',
  RequestStatus.denied: 'denied',
  RequestStatus.accepted: 'accepted',
  RequestStatus.onTheWay: 'onTheWay',
  RequestStatus.pending: 'pending',
};
