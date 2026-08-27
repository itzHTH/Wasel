import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/helpers/debouncer.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/usecases/search_places_use_case.dart';
import 'package:wasel_location/presentation/providers/location_di_providers.dart';
import 'package:wasel_location/presentation/providers/search/place_search_state.dart';
import 'package:wasel_location/presentation/providers/search/search_field_type.dart';

part 'place_search_controller.g.dart';

@riverpod
Duration placeSearchDebounce(Ref ref) => const Duration(milliseconds: 350);

const _minQueryLength = 3;

/// Debounced place search for a single SearchFieldType.
@riverpod
class PlaceSearchController extends _$PlaceSearchController {
  late SearchPlacesUseCase _useCase;
  late Debouncer _debouncer;

  /// Bumped by every input event, so a response that outlives its query can
  /// recognise itself as stale.
  var _generation = 0;

  /// Captured per request rather than calling `_useCase.cancel()`: the use case
  /// is a container-wide singleton, whose cancel would reach another consumer.
  CancelToken? _inFlight;

  GeoPoint? _proximity;

  @override
  PlaceSearchState build(SearchFieldType field) {
    _generation++;

    _useCase = ref.watch(searchPlacesUseCaseProvider);
    _debouncer = Debouncer(ref.watch(placeSearchDebounceProvider));

    ref.onDispose(() {
      _debouncer.dispose();
      _abortInFlight();
      _generation++;
    });

    return const PlaceSearchState();
  }

  void onQueryChanged(String raw, {GeoPoint? proximity}) {
    if (!ref.mounted) return;
    _proximity = proximity ?? _proximity;

    final query = raw.trim();
    final generation = _supersede();

    if (query.length < _minQueryLength) {
      state = const PlaceSearchState();
      return;
    }

    _markSearching(query);
    _debouncer.run(() => unawaited(_search(query, generation)));
  }

  /// The keyboard's search action — typing has stopped, so skip the debounce.
  void submit(String raw) {
    if (!ref.mounted) return;
    final query = raw.trim();
    if (query.length < _minQueryLength) return;

    final generation = _supersede();
    _markSearching(query);
    unawaited(_search(query, generation));
  }

  void clear() {
    if (!ref.mounted) return;
    _supersede();
    state = const PlaceSearchState();
  }

  int _supersede() {
    _debouncer.cancel();
    _abortInFlight();
    return ++_generation;
  }

  void _markSearching(String query) {
    state = state.copyWith(
      query: query,
      isSearching: true,
      clearSearchError: true,
    );
  }

  Future<void> _search(String query, int generation) async {
    try {
      final future = _useCase.call(
        PlaceSearchParams(
          query: query,
          proximity: _proximity,
          // Read from the static rather than watching the locale provider, which
          // would rebuild this notifier and wipe the query mid-typing.
          languageCode: AppLocalizationController.currentLocale.languageCode,
        ),
      );

      // `call` swaps in a fresh token synchronously before returning.
      _inFlight = _useCase.cancelToken;

      final result = await future;

      if (!_isCurrent(generation)) return;
      _inFlight = null;

      result.when(
        success: (suggestions) => state = state.copyWith(
          suggestions: List.unmodifiable(suggestions),
          isSearching: false,
          clearSearchError: true,
        ),
        // Results are dropped with the failure. Kept, they outrank the error
        // in `_phaseOf`, so the rider is left reading matches for a query that
        // never landed, with no error and no way to retry.
        failure: (error) => state = state.copyWith(
          suggestions: const [],
          isSearching: false,
          searchError: error,
        ),
      );
    } catch (error) {
      // Nothing below the repo should throw, but an unguarded throw here would
      // strand the field spinning forever.
      if (!_isCurrent(generation)) return;
      _inFlight = null;
      state = state.copyWith(
        suggestions: const [],
        isSearching: false,
        searchError: error,
      );
    }
  }

  bool _isCurrent(int generation) => ref.mounted && generation == _generation;

  void _abortInFlight() {
    if (_inFlight?.isCancelled == false) {
      _inFlight!.cancel('superseded by a newer place search');
    }
    _inFlight = null;
  }
}
