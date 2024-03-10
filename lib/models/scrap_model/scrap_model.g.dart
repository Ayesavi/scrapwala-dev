// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrap_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScrapModelImpl _$$ScrapModelImplFromJson(Map<String, dynamic> json) =>
    _$ScrapModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      measure:
          $enumDecodeNullable(_$ScrapMeasurementEnumMap, json['measure']) ??
              ScrapMeasurement.kg,
      isNegotiable: json['isNegotiable'] as bool? ?? false,
    );

Map<String, dynamic> _$$ScrapModelImplToJson(_$ScrapModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'description': instance.description,
      'price': instance.price,
      'measure': _$ScrapMeasurementEnumMap[instance.measure]!,
      'isNegotiable': instance.isNegotiable,
    };

const _$ScrapMeasurementEnumMap = {
  ScrapMeasurement.unit: 'unit',
  ScrapMeasurement.kg: 'kg',
  ScrapMeasurement.gm: 'gm',
  ScrapMeasurement.ltr: 'ltr',
  ScrapMeasurement.qntl: 'qntl',
};
