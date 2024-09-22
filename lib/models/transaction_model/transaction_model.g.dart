// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      transactionId: json['transactionId'] as String,
      requestId: json['requestId'] as String,
      pickupLocation:
          AddressModel.fromJson(json['pickupLocation'] as Map<String, dynamic>),
      pickupTime: DateTime.parse(json['pickupTime'] as String),
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderQuantity.fromJson(e as Map<String, dynamic>))
          .toList(),
      photograph: json['photograph'] as String?,
      paymentMode: json['paymentMode'] ?? PaymentMode.cash,
      totalAmountPaid: (json['totalAmountPaid'] as num).toInt(),
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'requestId': instance.requestId,
      'pickupLocation': instance.pickupLocation,
      'pickupTime': instance.pickupTime.toIso8601String(),
      'orders': instance.orders,
      'photograph': instance.photograph,
      'paymentMode': instance.paymentMode,
      'totalAmountPaid': instance.totalAmountPaid,
    };

_$OrderQuantityImpl _$$OrderQuantityImplFromJson(Map<String, dynamic> json) =>
    _$OrderQuantityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      measurement: $enumDecode(_$ScrapMeasurementEnumMap, json['measurement']),
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderQuantityImplToJson(_$OrderQuantityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'measurement': _$ScrapMeasurementEnumMap[instance.measurement]!,
      'quantity': instance.quantity,
      'price': instance.price,
    };

const _$ScrapMeasurementEnumMap = {
  ScrapMeasurement.unit: 'unit',
  ScrapMeasurement.kg: 'kg',
  ScrapMeasurement.gm: 'gm',
  ScrapMeasurement.ltr: 'ltr',
  ScrapMeasurement.qntl: 'qntl',
};
