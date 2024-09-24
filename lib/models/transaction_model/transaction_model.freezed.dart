// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  @JsonKey(name: 'id')
  int get transactionId => throw _privateConstructorUsedError;
  String get requestId => throw _privateConstructorUsedError;
  AddressModel get pickupLocation => throw _privateConstructorUsedError;
  DateTime get pickupTime => throw _privateConstructorUsedError;
  Map<String, dynamic> get orderQuantity => throw _privateConstructorUsedError;
  String? get photograph => throw _privateConstructorUsedError;
  dynamic get paymentMode => throw _privateConstructorUsedError;
  int get totalAmountPaid => throw _privateConstructorUsedError;

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int transactionId,
      String requestId,
      AddressModel pickupLocation,
      DateTime pickupTime,
      Map<String, dynamic> orderQuantity,
      String? photograph,
      dynamic paymentMode,
      int totalAmountPaid});

  $AddressModelCopyWith<$Res> get pickupLocation;
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? requestId = null,
    Object? pickupLocation = null,
    Object? pickupTime = null,
    Object? orderQuantity = null,
    Object? photograph = freezed,
    Object? paymentMode = freezed,
    Object? totalAmountPaid = null,
  }) {
    return _then(_value.copyWith(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      pickupLocation: null == pickupLocation
          ? _value.pickupLocation
          : pickupLocation // ignore: cast_nullable_to_non_nullable
              as AddressModel,
      pickupTime: null == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderQuantity: null == orderQuantity
          ? _value.orderQuantity
          : orderQuantity // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      photograph: freezed == photograph
          ? _value.photograph
          : photograph // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMode: freezed == paymentMode
          ? _value.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalAmountPaid: null == totalAmountPaid
          ? _value.totalAmountPaid
          : totalAmountPaid // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res> get pickupLocation {
    return $AddressModelCopyWith<$Res>(_value.pickupLocation, (value) {
      return _then(_value.copyWith(pickupLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(_$TransactionModelImpl value,
          $Res Function(_$TransactionModelImpl) then) =
      __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int transactionId,
      String requestId,
      AddressModel pickupLocation,
      DateTime pickupTime,
      Map<String, dynamic> orderQuantity,
      String? photograph,
      dynamic paymentMode,
      int totalAmountPaid});

  @override
  $AddressModelCopyWith<$Res> get pickupLocation;
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(_$TransactionModelImpl _value,
      $Res Function(_$TransactionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? requestId = null,
    Object? pickupLocation = null,
    Object? pickupTime = null,
    Object? orderQuantity = null,
    Object? photograph = freezed,
    Object? paymentMode = freezed,
    Object? totalAmountPaid = null,
  }) {
    return _then(_$TransactionModelImpl(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      pickupLocation: null == pickupLocation
          ? _value.pickupLocation
          : pickupLocation // ignore: cast_nullable_to_non_nullable
              as AddressModel,
      pickupTime: null == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderQuantity: null == orderQuantity
          ? _value._orderQuantity
          : orderQuantity // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      photograph: freezed == photograph
          ? _value.photograph
          : photograph // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMode: freezed == paymentMode ? _value.paymentMode! : paymentMode,
      totalAmountPaid: null == totalAmountPaid
          ? _value.totalAmountPaid
          : totalAmountPaid // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl implements _TransactionModel {
  _$TransactionModelImpl(
      {@JsonKey(name: 'id') required this.transactionId,
      required this.requestId,
      required this.pickupLocation,
      required this.pickupTime,
      required final Map<String, dynamic> orderQuantity,
      this.photograph,
      this.paymentMode = PaymentMode.cash,
      required this.totalAmountPaid})
      : _orderQuantity = orderQuantity;

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int transactionId;
  @override
  final String requestId;
  @override
  final AddressModel pickupLocation;
  @override
  final DateTime pickupTime;
  final Map<String, dynamic> _orderQuantity;
  @override
  Map<String, dynamic> get orderQuantity {
    if (_orderQuantity is EqualUnmodifiableMapView) return _orderQuantity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_orderQuantity);
  }

  @override
  final String? photograph;
  @override
  @JsonKey()
  final dynamic paymentMode;
  @override
  final int totalAmountPaid;

  @override
  String toString() {
    return 'TransactionModel(transactionId: $transactionId, requestId: $requestId, pickupLocation: $pickupLocation, pickupTime: $pickupTime, orderQuantity: $orderQuantity, photograph: $photograph, paymentMode: $paymentMode, totalAmountPaid: $totalAmountPaid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.pickupLocation, pickupLocation) ||
                other.pickupLocation == pickupLocation) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            const DeepCollectionEquality()
                .equals(other._orderQuantity, _orderQuantity) &&
            (identical(other.photograph, photograph) ||
                other.photograph == photograph) &&
            const DeepCollectionEquality()
                .equals(other.paymentMode, paymentMode) &&
            (identical(other.totalAmountPaid, totalAmountPaid) ||
                other.totalAmountPaid == totalAmountPaid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      transactionId,
      requestId,
      pickupLocation,
      pickupTime,
      const DeepCollectionEquality().hash(_orderQuantity),
      photograph,
      const DeepCollectionEquality().hash(paymentMode),
      totalAmountPaid);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(
      this,
    );
  }
}

abstract class _TransactionModel implements TransactionModel {
  factory _TransactionModel(
      {@JsonKey(name: 'id') required final int transactionId,
      required final String requestId,
      required final AddressModel pickupLocation,
      required final DateTime pickupTime,
      required final Map<String, dynamic> orderQuantity,
      final String? photograph,
      final dynamic paymentMode,
      required final int totalAmountPaid}) = _$TransactionModelImpl;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get transactionId;
  @override
  String get requestId;
  @override
  AddressModel get pickupLocation;
  @override
  DateTime get pickupTime;
  @override
  Map<String, dynamic> get orderQuantity;
  @override
  String? get photograph;
  @override
  dynamic get paymentMode;
  @override
  int get totalAmountPaid;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderQuantity _$OrderQuantityFromJson(Map<String, dynamic> json) {
  return _OrderQuantity.fromJson(json);
}

/// @nodoc
mixin _$OrderQuantity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ScrapMeasurement get measurement => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;

  /// Serializes this OrderQuantity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderQuantity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderQuantityCopyWith<OrderQuantity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderQuantityCopyWith<$Res> {
  factory $OrderQuantityCopyWith(
          OrderQuantity value, $Res Function(OrderQuantity) then) =
      _$OrderQuantityCopyWithImpl<$Res, OrderQuantity>;
  @useResult
  $Res call(
      {String id,
      String name,
      ScrapMeasurement measurement,
      int quantity,
      int price});
}

/// @nodoc
class _$OrderQuantityCopyWithImpl<$Res, $Val extends OrderQuantity>
    implements $OrderQuantityCopyWith<$Res> {
  _$OrderQuantityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderQuantity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? measurement = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      measurement: null == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as ScrapMeasurement,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderQuantityImplCopyWith<$Res>
    implements $OrderQuantityCopyWith<$Res> {
  factory _$$OrderQuantityImplCopyWith(
          _$OrderQuantityImpl value, $Res Function(_$OrderQuantityImpl) then) =
      __$$OrderQuantityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ScrapMeasurement measurement,
      int quantity,
      int price});
}

/// @nodoc
class __$$OrderQuantityImplCopyWithImpl<$Res>
    extends _$OrderQuantityCopyWithImpl<$Res, _$OrderQuantityImpl>
    implements _$$OrderQuantityImplCopyWith<$Res> {
  __$$OrderQuantityImplCopyWithImpl(
      _$OrderQuantityImpl _value, $Res Function(_$OrderQuantityImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderQuantity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? measurement = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_$OrderQuantityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      measurement: null == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as ScrapMeasurement,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderQuantityImpl implements _OrderQuantity {
  _$OrderQuantityImpl(
      {required this.id,
      required this.name,
      required this.measurement,
      required this.quantity,
      required this.price});

  factory _$OrderQuantityImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderQuantityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final ScrapMeasurement measurement;
  @override
  final int quantity;
  @override
  final int price;

  @override
  String toString() {
    return 'OrderQuantity(id: $id, name: $name, measurement: $measurement, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderQuantityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.measurement, measurement) ||
                other.measurement == measurement) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, measurement, quantity, price);

  /// Create a copy of OrderQuantity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderQuantityImplCopyWith<_$OrderQuantityImpl> get copyWith =>
      __$$OrderQuantityImplCopyWithImpl<_$OrderQuantityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderQuantityImplToJson(
      this,
    );
  }
}

abstract class _OrderQuantity implements OrderQuantity {
  factory _OrderQuantity(
      {required final String id,
      required final String name,
      required final ScrapMeasurement measurement,
      required final int quantity,
      required final int price}) = _$OrderQuantityImpl;

  factory _OrderQuantity.fromJson(Map<String, dynamic> json) =
      _$OrderQuantityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  ScrapMeasurement get measurement;
  @override
  int get quantity;
  @override
  int get price;

  /// Create a copy of OrderQuantity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderQuantityImplCopyWith<_$OrderQuantityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
