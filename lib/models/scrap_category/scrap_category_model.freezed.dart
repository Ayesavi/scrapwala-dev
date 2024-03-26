// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scrap_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScrapCategoryModel _$ScrapCategoryModelFromJson(Map<String, dynamic> json) {
  return _ScrapCategory.fromJson(json);
}

/// @nodoc
mixin _$ScrapCategoryModel {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  String? get bannerUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScrapCategoryModelCopyWith<ScrapCategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrapCategoryModelCopyWith<$Res> {
  factory $ScrapCategoryModelCopyWith(
          ScrapCategoryModel value, $Res Function(ScrapCategoryModel) then) =
      _$ScrapCategoryModelCopyWithImpl<$Res, ScrapCategoryModel>;
  @useResult
  $Res call({String name, String id, String photoUrl, String? bannerUrl});
}

/// @nodoc
class _$ScrapCategoryModelCopyWithImpl<$Res, $Val extends ScrapCategoryModel>
    implements $ScrapCategoryModelCopyWith<$Res> {
  _$ScrapCategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? photoUrl = null,
    Object? bannerUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      bannerUrl: freezed == bannerUrl
          ? _value.bannerUrl
          : bannerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScrapCategoryImplCopyWith<$Res>
    implements $ScrapCategoryModelCopyWith<$Res> {
  factory _$$ScrapCategoryImplCopyWith(
          _$ScrapCategoryImpl value, $Res Function(_$ScrapCategoryImpl) then) =
      __$$ScrapCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String id, String photoUrl, String? bannerUrl});
}

/// @nodoc
class __$$ScrapCategoryImplCopyWithImpl<$Res>
    extends _$ScrapCategoryModelCopyWithImpl<$Res, _$ScrapCategoryImpl>
    implements _$$ScrapCategoryImplCopyWith<$Res> {
  __$$ScrapCategoryImplCopyWithImpl(
      _$ScrapCategoryImpl _value, $Res Function(_$ScrapCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? photoUrl = null,
    Object? bannerUrl = freezed,
  }) {
    return _then(_$ScrapCategoryImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      bannerUrl: freezed == bannerUrl
          ? _value.bannerUrl
          : bannerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScrapCategoryImpl implements _ScrapCategory {
  const _$ScrapCategoryImpl(
      {required this.name,
      required this.id,
      required this.photoUrl,
      required this.bannerUrl});

  factory _$ScrapCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScrapCategoryImplFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  final String photoUrl;
  @override
  final String? bannerUrl;

  @override
  String toString() {
    return 'ScrapCategoryModel(name: $name, id: $id, photoUrl: $photoUrl, bannerUrl: $bannerUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrapCategoryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.bannerUrl, bannerUrl) ||
                other.bannerUrl == bannerUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id, photoUrl, bannerUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScrapCategoryImplCopyWith<_$ScrapCategoryImpl> get copyWith =>
      __$$ScrapCategoryImplCopyWithImpl<_$ScrapCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScrapCategoryImplToJson(
      this,
    );
  }
}

abstract class _ScrapCategory implements ScrapCategoryModel {
  const factory _ScrapCategory(
      {required final String name,
      required final String id,
      required final String photoUrl,
      required final String? bannerUrl}) = _$ScrapCategoryImpl;

  factory _ScrapCategory.fromJson(Map<String, dynamic> json) =
      _$ScrapCategoryImpl.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  String get photoUrl;
  @override
  String? get bannerUrl;
  @override
  @JsonKey(ignore: true)
  _$$ScrapCategoryImplCopyWith<_$ScrapCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
