// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pickup_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PickupRequestModel _$PickupRequestModelFromJson(Map<String, dynamic> json) {
  return _PickupRequestModel.fromJson(json);
}

/// @nodoc
mixin _$PickupRequestModel {
  String? get addressId => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  DateTime get requestDateTime => throw _privateConstructorUsedError;
  String get requestingUserId => throw _privateConstructorUsedError;
  DateTime? get scheduleDateTime => throw _privateConstructorUsedError;
  DateTime? get pickedDateTime => throw _privateConstructorUsedError;
  ({String address, String houseStreetNo, String label})? get address =>
      throw _privateConstructorUsedError;
  String get qtyRange => throw _privateConstructorUsedError;
  RequestStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PickupRequestModelCopyWith<PickupRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickupRequestModelCopyWith<$Res> {
  factory $PickupRequestModelCopyWith(
          PickupRequestModel value, $Res Function(PickupRequestModel) then) =
      _$PickupRequestModelCopyWithImpl<$Res, PickupRequestModel>;
  @useResult
  $Res call(
      {String? addressId,
      String id,
      DateTime requestDateTime,
      String requestingUserId,
      DateTime? scheduleDateTime,
      DateTime? pickedDateTime,
      ({String address, String houseStreetNo, String label})? address,
      String qtyRange,
      RequestStatus status});
}

/// @nodoc
class _$PickupRequestModelCopyWithImpl<$Res, $Val extends PickupRequestModel>
    implements $PickupRequestModelCopyWith<$Res> {
  _$PickupRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addressId = freezed,
    Object? id = null,
    Object? requestDateTime = null,
    Object? requestingUserId = null,
    Object? scheduleDateTime = freezed,
    Object? pickedDateTime = freezed,
    Object? address = freezed,
    Object? qtyRange = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestDateTime: null == requestDateTime
          ? _value.requestDateTime
          : requestDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requestingUserId: null == requestingUserId
          ? _value.requestingUserId
          : requestingUserId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleDateTime: freezed == scheduleDateTime
          ? _value.scheduleDateTime
          : scheduleDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pickedDateTime: freezed == pickedDateTime
          ? _value.pickedDateTime
          : pickedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as ({String address, String houseStreetNo, String label})?,
      qtyRange: null == qtyRange
          ? _value.qtyRange
          : qtyRange // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PickupRequestModelImplCopyWith<$Res>
    implements $PickupRequestModelCopyWith<$Res> {
  factory _$$PickupRequestModelImplCopyWith(_$PickupRequestModelImpl value,
          $Res Function(_$PickupRequestModelImpl) then) =
      __$$PickupRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? addressId,
      String id,
      DateTime requestDateTime,
      String requestingUserId,
      DateTime? scheduleDateTime,
      DateTime? pickedDateTime,
      ({String address, String houseStreetNo, String label})? address,
      String qtyRange,
      RequestStatus status});
}

/// @nodoc
class __$$PickupRequestModelImplCopyWithImpl<$Res>
    extends _$PickupRequestModelCopyWithImpl<$Res, _$PickupRequestModelImpl>
    implements _$$PickupRequestModelImplCopyWith<$Res> {
  __$$PickupRequestModelImplCopyWithImpl(_$PickupRequestModelImpl _value,
      $Res Function(_$PickupRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addressId = freezed,
    Object? id = null,
    Object? requestDateTime = null,
    Object? requestingUserId = null,
    Object? scheduleDateTime = freezed,
    Object? pickedDateTime = freezed,
    Object? address = freezed,
    Object? qtyRange = null,
    Object? status = null,
  }) {
    return _then(_$PickupRequestModelImpl(
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestDateTime: null == requestDateTime
          ? _value.requestDateTime
          : requestDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requestingUserId: null == requestingUserId
          ? _value.requestingUserId
          : requestingUserId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleDateTime: freezed == scheduleDateTime
          ? _value.scheduleDateTime
          : scheduleDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pickedDateTime: freezed == pickedDateTime
          ? _value.pickedDateTime
          : pickedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as ({String address, String houseStreetNo, String label})?,
      qtyRange: null == qtyRange
          ? _value.qtyRange
          : qtyRange // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PickupRequestModelImpl implements _PickupRequestModel {
  _$PickupRequestModelImpl(
      {required this.addressId,
      required this.id,
      required this.requestDateTime,
      required this.requestingUserId,
      this.scheduleDateTime,
      this.pickedDateTime,
      this.address,
      required this.qtyRange,
      this.status = RequestStatus.requested});

  factory _$PickupRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickupRequestModelImplFromJson(json);

  @override
  final String? addressId;
  @override
  final String id;
  @override
  final DateTime requestDateTime;
  @override
  final String requestingUserId;
  @override
  final DateTime? scheduleDateTime;
  @override
  final DateTime? pickedDateTime;
  @override
  final ({String address, String houseStreetNo, String label})? address;
  @override
  final String qtyRange;
  @override
  @JsonKey()
  final RequestStatus status;

  @override
  String toString() {
    return 'PickupRequestModel(addressId: $addressId, id: $id, requestDateTime: $requestDateTime, requestingUserId: $requestingUserId, scheduleDateTime: $scheduleDateTime, pickedDateTime: $pickedDateTime, address: $address, qtyRange: $qtyRange, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickupRequestModelImpl &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestDateTime, requestDateTime) ||
                other.requestDateTime == requestDateTime) &&
            (identical(other.requestingUserId, requestingUserId) ||
                other.requestingUserId == requestingUserId) &&
            (identical(other.scheduleDateTime, scheduleDateTime) ||
                other.scheduleDateTime == scheduleDateTime) &&
            (identical(other.pickedDateTime, pickedDateTime) ||
                other.pickedDateTime == pickedDateTime) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.qtyRange, qtyRange) ||
                other.qtyRange == qtyRange) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      addressId,
      id,
      requestDateTime,
      requestingUserId,
      scheduleDateTime,
      pickedDateTime,
      address,
      qtyRange,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PickupRequestModelImplCopyWith<_$PickupRequestModelImpl> get copyWith =>
      __$$PickupRequestModelImplCopyWithImpl<_$PickupRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PickupRequestModelImplToJson(
      this,
    );
  }
}

abstract class _PickupRequestModel implements PickupRequestModel {
  factory _PickupRequestModel(
      {required final String? addressId,
      required final String id,
      required final DateTime requestDateTime,
      required final String requestingUserId,
      final DateTime? scheduleDateTime,
      final DateTime? pickedDateTime,
      final ({String address, String houseStreetNo, String label})? address,
      required final String qtyRange,
      final RequestStatus status}) = _$PickupRequestModelImpl;

  factory _PickupRequestModel.fromJson(Map<String, dynamic> json) =
      _$PickupRequestModelImpl.fromJson;

  @override
  String? get addressId;
  @override
  String get id;
  @override
  DateTime get requestDateTime;
  @override
  String get requestingUserId;
  @override
  DateTime? get scheduleDateTime;
  @override
  DateTime? get pickedDateTime;
  @override
  ({String address, String houseStreetNo, String label})? get address;
  @override
  String get qtyRange;
  @override
  RequestStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$PickupRequestModelImplCopyWith<_$PickupRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
