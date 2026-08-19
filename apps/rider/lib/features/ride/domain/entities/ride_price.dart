class RidePrice {
  final num estimatedPrice;
  final String distanceInKm;
  final String currency;

  RidePrice({
    required this.estimatedPrice,
    required this.distanceInKm,
    this.currency = 'IQD',
  });
}
