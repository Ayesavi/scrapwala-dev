// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PickupRequestModelImpl _$$PickupRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PickupRequestModelImpl(
      addressId: json['addressId'] as String,
      id: json['id'] as String,
      requestDateTime: DateTime.parse(json['requestDateTime'] as String),
      requestingUserId: json['requestingUserId'] as String,
      scheduleDateTime: json['scheduleDateTime'] == null
          ? null
          : DateTime.parse(json['scheduleDateTime'] as String),
      pickedDateTime: json['pickedDateTime'] == null
          ? null
          : DateTime.parse(json['pickedDateTime'] as String),
      totalPrice: json['totalPrice'] as int,
      status: $enumDecodeNullable(_$RequestStatusEnumMap, json['status']) ??
          RequestStatus.pending,
      quantity: Map<String, int>.from(json['quantity'] as Map),
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
      'totalPrice': instance.totalPrice,
      'status': _$RequestStatusEnumMap[instance.status]!,
      'quantity': instance.quantity,
    };

const _$RequestStatusEnumMap = {
  RequestStatus.picked: 'picked',
  RequestStatus.pending: 'pending',
  RequestStatus.denied: 'denied',
};
