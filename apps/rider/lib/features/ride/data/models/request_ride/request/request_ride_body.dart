import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';

class RequestRideBody {
  final GeoPointRequestBody geoPointRequest;
  final int paymentMethod;
  final String? paymentToken;

  RequestRideBody({
    required this.geoPointRequest,
    required this.paymentMethod,
    this.paymentToken,
  });

  Map<String, dynamic> toJson() => {
    ...geoPointRequest.toJson(),
    'paymentMethod': paymentMethod,
    if (paymentToken != null) 'paymentToken': paymentToken,
  };
}
