import 'package:wasel_rides/domain/entities/ride_history_entry.dart';

/// Everything the history screen renders from.
class RideHistoryState {
  final List<RideHistoryEntry> entries;

  final int nextPage;

  final bool hasMore;

  final bool isLoadingMore;

  /// Set when appending a page failed. The already-loaded [entries] are kept,
  /// so a failed page 3 never blanks out pages 1–2.
  final Object? loadMoreError;

  const RideHistoryState({
    required this.entries,
    required this.nextPage,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  bool get isEmpty => entries.isEmpty;

  RideHistoryState copyWith({
    List<RideHistoryEntry>? entries,
    int? nextPage,
    bool? hasMore,
    bool? isLoadingMore,
    Object? loadMoreError,
    bool clearLoadMoreError = false,
  }) {
    return RideHistoryState(
      entries: entries ?? this.entries,
      nextPage: nextPage ?? this.nextPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: clearLoadMoreError
          ? null
          : (loadMoreError ?? this.loadMoreError),
    );
  }
}
