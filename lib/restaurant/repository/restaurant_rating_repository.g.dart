// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_rating_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestaurantRatingRepository implements RestaurantRatingRepository {
  _RestaurantRatingRepository(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CursorPagination<RatingModel>> paginate(
      {paginationParams = const PaginationParams()}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(paginationParams?.toJson() ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'accessToken': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CursorPagination<RatingModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CursorPagination<RatingModel>.fromJson(
      _result.data!,
      (json) => RatingModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gRestaurantRatingRepositoryHash() =>
    r'459a917c76785bae84a320566a532f5e6cf932c9';

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

typedef GRestaurantRatingRepositoryRef
    = AutoDisposeProviderRef<RestaurantRatingRepository>;

/// See also [gRestaurantRatingRepository].
@ProviderFor(gRestaurantRatingRepository)
const gRestaurantRatingRepositoryProvider = GRestaurantRatingRepositoryFamily();

/// See also [gRestaurantRatingRepository].
class GRestaurantRatingRepositoryFamily
    extends Family<RestaurantRatingRepository> {
  /// See also [gRestaurantRatingRepository].
  const GRestaurantRatingRepositoryFamily();

  /// See also [gRestaurantRatingRepository].
  GRestaurantRatingRepositoryProvider call({
    required String id,
  }) {
    return GRestaurantRatingRepositoryProvider(
      id: id,
    );
  }

  @override
  GRestaurantRatingRepositoryProvider getProviderOverride(
    covariant GRestaurantRatingRepositoryProvider provider,
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
  String? get name => r'gRestaurantRatingRepositoryProvider';
}

/// See also [gRestaurantRatingRepository].
class GRestaurantRatingRepositoryProvider
    extends AutoDisposeProvider<RestaurantRatingRepository> {
  /// See also [gRestaurantRatingRepository].
  GRestaurantRatingRepositoryProvider({
    required this.id,
  }) : super.internal(
          (ref) => gRestaurantRatingRepository(
            ref,
            id: id,
          ),
          from: gRestaurantRatingRepositoryProvider,
          name: r'gRestaurantRatingRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gRestaurantRatingRepositoryHash,
          dependencies: GRestaurantRatingRepositoryFamily._dependencies,
          allTransitiveDependencies:
              GRestaurantRatingRepositoryFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GRestaurantRatingRepositoryProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
