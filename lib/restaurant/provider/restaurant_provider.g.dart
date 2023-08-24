// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gRestaurantDetailHash() => r'b03fad546d15780571d5a2daf93940f5900ed1cb';

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

typedef GRestaurantDetailRef = AutoDisposeProviderRef<RestaurantModel?>;

/// See also [gRestaurantDetail].
@ProviderFor(gRestaurantDetail)
const gRestaurantDetailProvider = GRestaurantDetailFamily();

/// See also [gRestaurantDetail].
class GRestaurantDetailFamily extends Family<RestaurantModel?> {
  /// See also [gRestaurantDetail].
  const GRestaurantDetailFamily();

  /// See also [gRestaurantDetail].
  GRestaurantDetailProvider call({
    required String id,
  }) {
    return GRestaurantDetailProvider(
      id: id,
    );
  }

  @override
  GRestaurantDetailProvider getProviderOverride(
    covariant GRestaurantDetailProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'gRestaurantDetailProvider';
}

/// See also [gRestaurantDetail].
class GRestaurantDetailProvider extends AutoDisposeProvider<RestaurantModel?> {
  /// See also [gRestaurantDetail].
  GRestaurantDetailProvider({
    required this.id,
  }) : super.internal(
          (ref) => gRestaurantDetail(
            ref,
            id: id,
          ),
          from: gRestaurantDetailProvider,
          name: r'gRestaurantDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gRestaurantDetailHash,
          dependencies: GRestaurantDetailFamily._dependencies,
          allTransitiveDependencies:
              GRestaurantDetailFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GRestaurantDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
