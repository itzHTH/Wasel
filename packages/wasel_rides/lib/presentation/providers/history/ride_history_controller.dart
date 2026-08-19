import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/paged/paged_list.dart';
import 'package:wasel_rides/domain/entities/ride_history_entry.dart';
import 'package:wasel_rides/domain/usecases/get_ride_history_use_case.dart';
import 'package:wasel_rides/presentation/providers/rides_di_providers.dart';
import 'package:wasel_rides/presentation/providers/history/ride_history_state.dart';

part 'ride_history_controller.g.dart';

Duration? _noRetry(int retryCount, Object error) => null;

/// Paginated ride history.
@Riverpod(retry: _noRetry)
class RideHistoryController extends _$RideHistoryController {
  static const int pageSize = 15;

  late GetRideHistoryUseCase _useCase;

  /// Bumped on every (re)build so a page still in flight from a previous
  /// generation can tell that it has been superseded.
  var _generation = 0;

  @override
  Future<RideHistoryState> build() async {
    _generation++;

    _useCase = ref.watch(getRideHistoryUseCaseProvider);
    ref.onDispose(_useCase.cancel);

    final page = await _fetch(1);

    return RideHistoryState(
      entries: List.unmodifiable(page.items),
      nextPage: page.currentPage + 1,
      hasMore: _hasMore(page),
    );
  }

  /// Reloads from page 1.
  Future<void> refresh() async {
    ref.invalidateSelf();
    try {
      await future;
    } catch (_) {}
  }

  /// Appends the next page.
  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    final generation = _generation;

    state = AsyncData(
      current.copyWith(isLoadingMore: true, clearLoadMoreError: true),
    );

    try {
      final page = await _fetch(current.nextPage);
      if (!_isCurrent(generation)) return;

      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(
          entries: List.unmodifiable([...latest.entries, ...page.items]),
          nextPage: page.currentPage + 1,
          hasMore: _hasMore(page),
          isLoadingMore: false,
        ),
      );
    } catch (error) {
      if (!_isCurrent(generation)) return;

      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(isLoadingMore: false, loadMoreError: error),
      );
    }
  }

  /// A refresh replaces the list wholesale, so a page that was requested
  /// before it must not be appended afterwards — doing so would splice a
  /// stale page onto fresh results and skip whatever shifted between them.
  /// `ref.mounted` cannot detect this: it stays true across `invalidateSelf`.
  bool _isCurrent(int generation) => ref.mounted && generation == _generation;

  /// An empty page means there is nothing further to show, whatever the
  /// server's page count claims
  bool _hasMore(PagedList<RideHistoryEntry> page) =>
      page.hasMore && page.items.isNotEmpty;

  Future<PagedList<RideHistoryEntry>> _fetch(int pageNumber) async {
    final result = await _useCase.call(
      RideHistoryPageParams(pageNumber: pageNumber, pageSize: pageSize),
    );

    return result.when(
      success: (page) => page,
      failure: (error) => throw error,
    );
  }
}
