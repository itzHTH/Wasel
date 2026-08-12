/// A coordinate pair, and the only geographic type the domain layer speaks.
///
/// Deliberately free of `google_maps_flutter`: lifting a point onto `LatLng`
/// happens at the UI edge via `GeoPointMapX.toLatLng()`, which keeps the domain
/// (and every use case built on it) independent of the map package.
///
/// Value equality matters here — Riverpod families such as `pointLabel(point)`
/// key their cache off this type, so two structurally equal points must resolve
/// to the same provider instance rather than refetching a label per rebuild.
class GeoPoint {
  final double latitude;
  final double longitude;

  const GeoPoint({required this.latitude, required this.longitude});

  @override
  bool operator ==(Object other) =>
      other is GeoPoint &&
      other.latitude == latitude &&
      other.longitude == longitude;

  @override
  int get hashCode => Object.hash(latitude, longitude);

  @override
  String toString() => 'GeoPoint($latitude, $longitude)';
}
