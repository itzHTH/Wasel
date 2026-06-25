import 'package:wasel_core/flavors/flavors_config.dart';
import 'package:driver/main_common.dart';

void main() {
  mainCommon(
    flavor: Flavor.development,
    appName: 'Wasel Driver Dev',
    // TODO(me): driver dev base URL (using the shared backend for now).
    baseUrl: 'https://apiservice.ddns.net/wasl',
  );
}
