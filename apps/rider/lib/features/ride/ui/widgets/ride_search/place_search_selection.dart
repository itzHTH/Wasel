import 'package:wasel_location/wasel_location.dart';

/// A place the rider chose, resolved to a point.
class PickedPlace {
  const PickedPlace({required this.name, required this.point});

  final String name;
  final GeoPoint point;
}

/// What the rider settled on by the time the search screen closed.
typedef PlaceSearchSelection = ({
  PickedPlace finalPick,
  SearchFieldType finalField,
});
