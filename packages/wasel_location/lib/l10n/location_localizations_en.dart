// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'location_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LocationLocalizationsEn extends LocationLocalizations {
  LocationLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get enable => 'Enable';

  @override
  String get locationPermissionRequired => 'Location permission required';

  @override
  String get locationPermissionRequiredMessage =>
      'Please enable location permission to use this feature.';

  @override
  String get turnOnLocation => 'Turn on location so we can find you';

  @override
  String get locationServiceOff =>
      'Location services are off. Turn them on so we can find you.';

  @override
  String get locationPermissionMissing =>
      'We can\'t reach your location without permission';

  @override
  String get locationNotFound => 'We couldn\'t find your location. Try again.';

  @override
  String get locationError =>
      'Something went wrong while finding your location';

  @override
  String get addressSeparator => ', ';

  @override
  String get searchPlaceHint => 'Search for a place';

  @override
  String get searchPromptTitle => 'Start typing';

  @override
  String get searchPromptMessage =>
      'Type an area or street name and nearby places will appear';

  @override
  String get searchNoResultsTitle => 'We couldn\'t find that place';

  @override
  String get searchNoResultsMessage =>
      'Try spelling it differently, or search for a nearby area';

  @override
  String get searchFailedTitle => 'We couldn\'t search';

  @override
  String get currentLocation => 'My current location';

  @override
  String get clearSearchField => 'Clear search';

  @override
  String get searchResultsLabel => 'Search results';

  @override
  String get pickupRequiredFirst => 'Please choose your pickup point first';
}
