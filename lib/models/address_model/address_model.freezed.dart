// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return _AddressModel.fromJson(json);
}

/// @nodoc
mixin _$AddressModel {
  String get address => throw _privateConstructorUsedError;
  String get houseStreetNo => throw _privateConstructorUsedError;
  String? get apartmentRoadAreadLandmark => throw _privateConstructorUsedError;
  ({double lat, double lng}) get latlng => throw _privateConstructorUsedError;
  String? get ownerId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  AddressCategory get category => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressModelCopyWith<AddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressModelCopyWith<$Res> {
  factory $AddressModelCopyWith(
          AddressModel value, $Res Function(AddressModel) then) =
      _$AddressModelCopyWithImpl<$Res, AddressModel>;
  @useResult
  $Res call(
      {String address,
      String houseStreetNo,
      String? apartmentRoadAreadLandmark,
      ({double lat, double lng}) latlng,
      String? ownerId,
      DateTime createdAt,
      String id,
      String? phoneNumber,
      AddressCategory category,
      String label});
}

/// @nodoc
class _$AddressModelCopyWithImpl<$Res, $Val extends AddressModel>
    implements $AddressModelCopyWith<$Res> {
  _$AddressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? houseStreetNo = null,
    Object? apartmentRoadAreadLandmark = freezed,
    Object? latlng = null,
    Object? ownerId = freezed,
    Object? createdAt = null,
    Object? id = null,
    Object? phoneNumber = freezed,
    Object? category = null,
    Object? label = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      houseStreetNo: null == houseStreetNo
          ? _value.houseStreetNo
          : houseStreetNo // ignore: cast_nullable_to_non_nullable
              as String,
      apartmentRoadAreadLandmark: freezed == apartmentRoadAreadLandmark
          ? _value.apartmentRoadAreadLandmark
          : apartmentRoadAreadLandmark // ignore: cast_nullable_to_non_nullable
              as String?,
      latlng: null == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as ({double lat, double lng}),
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as AddressCategory,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressModelImplCopyWith<$Res>
    implements $AddressModelCopyWith<$Res> {
  factory _$$AddressModelImplCopyWith(
          _$AddressModelImpl value, $Res Function(_$AddressModelImpl) then) =
      __$$AddressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String houseStreetNo,
      String? apartmentRoadAreadLandmark,
      ({double lat, double lng}) latlng,
      String? ownerId,
      DateTime createdAt,
      String id,
      String? phoneNumber,
      AddressCategory category,
      String label});
}

/// @nodoc
class __$$AddressModelImplCopyWithImpl<$Res>
    extends _$AddressModelCopyWithImpl<$Res, _$AddressModelImpl>
    implements _$$AddressModelImplCopyWith<$Res> {
  __$$AddressModelImplCopyWithImpl(
      _$AddressModelImpl _value, $Res Function(_$AddressModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? houseStreetNo = null,
    Object? apartmentRoadAreadLandmark = freezed,
    Object? latlng = null,
    Object? ownerId = freezed,
    Object? createdAt = null,
    Object? id = null,
    Object? phoneNumber = freezed,
    Object? category = null,
    Object? label = null,
  }) {
    return _then(_$AddressModelImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      houseStreetNo: null == houseStreetNo
          ? _value.houseStreetNo
          : houseStreetNo // ignore: cast_nullable_to_non_nullable
              as String,
      apartmentRoadAreadLandmark: freezed == apartmentRoadAreadLandmark
          ? _value.apartmentRoadAreadLandmark
          : apartmentRoadAreadLandmark // ignore: cast_nullable_to_non_nullable
              as String?,
      latlng: null == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as ({double lat, double lng}),
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as AddressCategory,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressModelImpl implements _AddressModel {
  _$AddressModelImpl(
      {required this.address,
      required this.houseStreetNo,
      this.apartmentRoadAreadLandmark,
      required this.latlng,
      this.ownerId,
      required this.createdAt,
      required this.id,
      this.phoneNumber,
      required this.category,
      required this.label});

  factory _$AddressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressModelImplFromJson(json);

  @override
  final String address;
  @override
  final String houseStreetNo;
  @override
  final String? apartmentRoadAreadLandmark;
  @override
  final ({double lat, double lng}) latlng;
  @override
  final String? ownerId;
  @override
  final DateTime createdAt;
  @override
  final String id;
  @override
  final String? phoneNumber;
  @override
  final AddressCategory category;
  @override
  final String label;

  @override
  String toString() {
    return 'AddressModel(address: $address, houseStreetNo: $houseStreetNo, apartmentRoadAreadLandmark: $apartmentRoadAreadLandmark, latlng: $latlng, ownerId: $ownerId, createdAt: $createdAt, id: $id, phoneNumber: $phoneNumber, category: $category, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressModelImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.houseStreetNo, houseStreetNo) ||
                other.houseStreetNo == houseStreetNo) &&
            (identical(other.apartmentRoadAreadLandmark,
                    apartmentRoadAreadLandmark) ||
                other.apartmentRoadAreadLandmark ==
                    apartmentRoadAreadLandmark) &&
            (identical(other.latlng, latlng) || other.latlng == latlng) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      address,
      houseStreetNo,
      apartmentRoadAreadLandmark,
      latlng,
      ownerId,
      createdAt,
      id,
      phoneNumber,
      category,
      label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      __$$AddressModelImplCopyWithImpl<_$AddressModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressModelImplToJson(
      this,
    );
  }
}

abstract class _AddressModel implements AddressModel {
  factory _AddressModel(
      {required final String address,
      required final String houseStreetNo,
      final String? apartmentRoadAreadLandmark,
      required final ({double lat, double lng}) latlng,
      final String? ownerId,
      required final DateTime createdAt,
      required final String id,
      final String? phoneNumber,
      required final AddressCategory category,
      required final String label}) = _$AddressModelImpl;

  factory _AddressModel.fromJson(Map<String, dynamic> json) =
      _$AddressModelImpl.fromJson;

  @override
  String get address;
  @override
  String get houseStreetNo;
  @override
  String? get apartmentRoadAreadLandmark;
  @override
  ({double lat, double lng}) get latlng;
  @override
  String? get ownerId;
  @override
  DateTime get createdAt;
  @override
  String get id;
  @override
  String? get phoneNumber;
  @override
  AddressCategory get category;
  @override
  String get label;
  @override
  @JsonKey(ignore: true)
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
