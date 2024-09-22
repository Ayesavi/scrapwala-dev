// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      address: json['address'] as String,
      houseStreetNo: json['houseStreetNo'] as String,
      apartmentRoadAreadLandmark: json['apartmentRoadAreadLandmark'] as String?,
      latlng: _$recordConvert(
        json['latlng'],
        ($jsonValue) => (
          lat: ($jsonValue['lat'] as num).toDouble(),
          lng: ($jsonValue['lng'] as num).toDouble(),
        ),
      ),
      ownerId: json['ownerId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      category: $enumDecode(_$AddressCategoryEnumMap, json['category']),
      label: json['label'] as String,
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'houseStreetNo': instance.houseStreetNo,
      'apartmentRoadAreadLandmark': instance.apartmentRoadAreadLandmark,
      'latlng': <String, dynamic>{
        'lat': instance.latlng.lat,
        'lng': instance.latlng.lng,
      },
      'ownerId': instance.ownerId,
      'createdAt': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'category': _$AddressCategoryEnumMap[instance.category]!,
      'label': instance.label,
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

const _$AddressCategoryEnumMap = {
  AddressCategory.friend: 'friend',
  AddressCategory.house: 'house',
  AddressCategory.office: 'office',
  AddressCategory.others: 'others',
};
