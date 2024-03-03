// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrap_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScrapModelImpl _$$ScrapModelImplFromJson(Map<String, dynamic> json) =>
    _$ScrapModelImpl(
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      isNegotiable: json['isNegotiable'] as bool? ?? false,
    );

Map<String, dynamic> _$$ScrapModelImplToJson(_$ScrapModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'description': instance.description,
      'price': instance.price,
      'isNegotiable': instance.isNegotiable,
    };
