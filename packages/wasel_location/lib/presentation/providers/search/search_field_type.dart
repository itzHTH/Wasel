/// Which of a ride's two endpoints a search field is editing.
enum SearchFieldType {
  pickup,
  dropoff;

  bool get isPickup => this == SearchFieldType.pickup;
}
