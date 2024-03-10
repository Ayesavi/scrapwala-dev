// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scrap_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScrapModel _$ScrapModelFromJson(Map<String, dynamic> json) {
  return _ScrapModel.fromJson(json);
}

/// @nodoc
mixin _$ScrapModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  ScrapMeasurement get measure => throw _privateConstructorUsedError;
  bool get isNegotiable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScrapModelCopyWith<ScrapModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrapModelCopyWith<$Res> {
  factory $ScrapModelCopyWith(
          ScrapModel value, $Res Function(ScrapModel) then) =
      _$ScrapModelCopyWithImpl<$Res, ScrapModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? photoUrl,
      String description,
      double price,
      ScrapMeasurement measure,
      bool isNegotiable});
}

/// @nodoc
class _$ScrapModelCopyWithImpl<$Res, $Val extends ScrapModel>
    implements $ScrapModelCopyWith<$Res> {
  _$ScrapModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? description = null,
    Object? price = null,
    Object? measure = null,
    Object? isNegotiable = null,
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
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      measure: null == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as ScrapMeasurement,
      isNegotiable: null == isNegotiable
          ? _value.isNegotiable
          : isNegotiable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScrapModelImplCopyWith<$Res>
    implements $ScrapModelCopyWith<$Res> {
  factory _$$ScrapModelImplCopyWith(
          _$ScrapModelImpl value, $Res Function(_$ScrapModelImpl) then) =
      __$$ScrapModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? photoUrl,
      String description,
      double price,
      ScrapMeasurement measure,
      bool isNegotiable});
}

/// @nodoc
class __$$ScrapModelImplCopyWithImpl<$Res>
    extends _$ScrapModelCopyWithImpl<$Res, _$ScrapModelImpl>
    implements _$$ScrapModelImplCopyWith<$Res> {
  __$$ScrapModelImplCopyWithImpl(
      _$ScrapModelImpl _value, $Res Function(_$ScrapModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? description = null,
    Object? price = null,
    Object? measure = null,
    Object? isNegotiable = null,
  }) {
    return _then(_$ScrapModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      measure: null == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as ScrapMeasurement,
      isNegotiable: null == isNegotiable
          ? _value.isNegotiable
          : isNegotiable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScrapModelImpl implements _ScrapModel {
  const _$ScrapModelImpl(
      {required this.id,
      required this.name,
      this.photoUrl,
      required this.description,
      required this.price,
      this.measure = ScrapMeasurement.kg,
      this.isNegotiable = false});

  factory _$ScrapModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScrapModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? photoUrl;
  @override
  final String description;
  @override
  final double price;
  @override
  @JsonKey()
  final ScrapMeasurement measure;
  @override
  @JsonKey()
  final bool isNegotiable;

  @override
  String toString() {
    return 'ScrapModel(id: $id, name: $name, photoUrl: $photoUrl, description: $description, price: $price, measure: $measure, isNegotiable: $isNegotiable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrapModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.measure, measure) || other.measure == measure) &&
            (identical(other.isNegotiable, isNegotiable) ||
                other.isNegotiable == isNegotiable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photoUrl, description,
      price, measure, isNegotiable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScrapModelImplCopyWith<_$ScrapModelImpl> get copyWith =>
      __$$ScrapModelImplCopyWithImpl<_$ScrapModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScrapModelImplToJson(
      this,
    );
  }
}

abstract class _ScrapModel implements ScrapModel {
  const factory _ScrapModel(
      {required final String id,
      required final String name,
      final String? photoUrl,
      required final String description,
      required final double price,
      final ScrapMeasurement measure,
      final bool isNegotiable}) = _$ScrapModelImpl;

  factory _ScrapModel.fromJson(Map<String, dynamic> json) =
      _$ScrapModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get photoUrl;
  @override
  String get description;
  @override
  double get price;
  @override
  ScrapMeasurement get measure;
  @override
  bool get isNegotiable;
  @override
  @JsonKey(ignore: true)
  _$$ScrapModelImplCopyWith<_$ScrapModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
