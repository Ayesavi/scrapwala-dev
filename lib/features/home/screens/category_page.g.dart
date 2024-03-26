// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getScrapsHash() => r'570701a6128322b751a0d773c2e4530fcb64db6f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getScraps].
@ProviderFor(getScraps)
const getScrapsProvider = GetScrapsFamily();

/// See also [getScraps].
class GetScrapsFamily extends Family<AsyncValue<List<ScrapModel>>> {
  /// See also [getScraps].
  const GetScrapsFamily();

  /// See also [getScraps].
  GetScrapsProvider call(
    String id,
  ) {
    return GetScrapsProvider(
      id,
    );
  }

  @override
  GetScrapsProvider getProviderOverride(
    covariant GetScrapsProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getScrapsProvider';
}

/// See also [getScraps].
class GetScrapsProvider extends AutoDisposeFutureProvider<List<ScrapModel>> {
  /// See also [getScraps].
  GetScrapsProvider(
    String id,
  ) : this._internal(
          (ref) => getScraps(
            ref as GetScrapsRef,
            id,
          ),
          from: getScrapsProvider,
          name: r'getScrapsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getScrapsHash,
          dependencies: GetScrapsFamily._dependencies,
          allTransitiveDependencies: GetScrapsFamily._allTransitiveDependencies,
          id: id,
        );

  GetScrapsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<List<ScrapModel>> Function(GetScrapsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetScrapsProvider._internal(
        (ref) => create(ref as GetScrapsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ScrapModel>> createElement() {
    return _GetScrapsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetScrapsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetScrapsRef on AutoDisposeFutureProviderRef<List<ScrapModel>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GetScrapsProviderElement
    extends AutoDisposeFutureProviderElement<List<ScrapModel>>
    with GetScrapsRef {
  _GetScrapsProviderElement(super.provider);

  @override
  String get id => (origin as GetScrapsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
