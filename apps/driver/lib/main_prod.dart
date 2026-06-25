import 'package:wasel_core/flavors/flavors_config.dart';
import 'package:driver/main_common.dart';

void main() {
  mainCommon(
    flavor: Flavor.production,
    appName: 'Wasel Driver',
    // TODO(me): driver production base URL (using the shared backend for now).
    baseUrl: 'https://apiservice.ddns.net/wasl',
  );
}
