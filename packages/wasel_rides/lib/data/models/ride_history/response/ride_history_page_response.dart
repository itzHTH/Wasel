import 'package:wasel_core/networking/paged/paged_list.dart';
import 'package:wasel_core/networking/paged/paged_list_response.dart';
import 'package:wasel_rides/data/models/ride_history/response/ride_history_item_response.dart';
import 'package:wasel_rides/domain/entities/ride_history_entry.dart';

/// Unwraps the standard `ApiResponse<T>` envelope around the paged history,
/// matching how the profile responses read `json['data']`.
class RideHistoryPageResponse {
  final PagedListResponse<RideHistoryItemResponse> page;

  const RideHistoryPageResponse(this.page);

  factory RideHistoryPageResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    // A succeeded-but-empty response sends data: null; that is an empty
    // page, not a parse failure.
    if (data is! Map<String, dynamic>) {
      return const RideHistoryPageResponse(
        PagedListResponse<RideHistoryItemResponse>(
          items: [],
          currentPage: 0,
          totalPages: 0,
          pageSize: 0,
          totalCount: 0,
        ),
      );
    }

    return RideHistoryPageResponse(
      PagedListResponse<RideHistoryItemResponse>.fromJson(
        data,
        (item) =>
            RideHistoryItemResponse.fromJson(item as Map<String, dynamic>),
      ),
    );
  }

  PagedList<RideHistoryEntry> toEntity() =>
      page.toEntity((item) => item.toEntity());
}
