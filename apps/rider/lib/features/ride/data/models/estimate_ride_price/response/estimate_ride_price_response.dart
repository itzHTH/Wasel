import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';

part 'estimate_ride_price_response.g.dart';

@JsonSerializable()
class EstimateRidePriceResponse {
  final String estimatedPrice;
  final String distanceInKm;
  final String currency;

  EstimateRidePriceResponse({
    required this.estimatedPrice,
    required this.distanceInKm,
    required this.currency,
  });

  factory EstimateRidePriceResponse.fromJson(Map<String, dynamic> json) =>
      _$EstimateRidePriceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EstimateRidePriceResponseToJson(this);

  RidePrice toEntity() {
    return RidePrice(
      estimatedPrice: estimatedPrice,
      distanceInKm: distanceInKm,
      currency: currency,
    );
  }
}
