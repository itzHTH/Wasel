/// One page of a server-paginated collection.
class PagedList<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;

  const PagedList({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
  });

  const PagedList.empty()
    : items = const [],
      currentPage = 0,
      totalPages = 0,
      pageSize = 0,
      totalCount = 0;

  bool get hasMore => currentPage < totalPages;

  bool get isEmpty => items.isEmpty;
}
