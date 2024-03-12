// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      id: json['id'] as String,
      scrap: ScrapModel.fromJson(json['scrap'] as Map<String, dynamic>),
      qty: json['qty'] as int,
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scrap': instance.scrap,
      'qty': instance.qty,
    };
