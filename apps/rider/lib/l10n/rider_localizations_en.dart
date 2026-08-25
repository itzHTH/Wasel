// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'rider_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class RiderLocalizationsEn extends RiderLocalizations {
  RiderLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get brandName => 'Wasel';

  @override
  String get authHeaderTagline => 'Get a great experience with ';

  @override
  String get loginTagline => 'Book a taxi anytime';

  @override
  String get registerTagline => 'Book a taxi anytime';

  @override
  String get orSignUpWith => 'Or sign up with';

  @override
  String get signUpWithGoogle => 'Sign up with Google';

  @override
  String get registerWithGoogle => 'Sign up with Google';

  @override
  String get loginWithGoogle => 'Log in with Google';

  @override
  String get myAccount => 'My account';

  @override
  String get profileDetails => 'Profile';

  @override
  String get rideHistory => 'Ride history';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirmMessage =>
      'Are you sure you want to log out of your account?';

  @override
  String get requestRideFailed => 'We couldn\'t send your request, try again';

  @override
  String get logoutFailed => 'Logout failed';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get profileLoadFailed => 'We couldn\'t load your profile';

  @override
  String get edit => 'Edit';

  @override
  String get defaultUserName => 'Wasel user';

  @override
  String get balance => 'Balance';

  @override
  String get currencyIqd => 'IQD';

  @override
  String distanceKm(String value) {
    return '$value km';
  }

  @override
  String coordinatePair(String lat, String lng) {
    return '$lat, $lng';
  }

  @override
  String get whereToGo => 'Where do you want to go?';

  @override
  String get setPickup => 'Set your pickup point';

  @override
  String get confirmDestination => 'Confirm destination';

  @override
  String get confirmPickup => 'Confirm pickup';

  @override
  String get fromLabel => 'From';

  @override
  String get toLabel => 'To';

  @override
  String get pickupLabel => 'Pickup';

  @override
  String get destinationLabel => 'Destination';

  @override
  String get estimatedFare => 'Estimated fare';

  @override
  String get distanceLabel => 'Distance';

  @override
  String get paymentMethodLabel => 'Payment method';

  @override
  String get confirmRequest => 'Confirm request';

  @override
  String get checkDetails => 'Check the details';

  @override
  String get cancelRequest => 'Cancel request';

  @override
  String get searchingForCaptain => 'Looking for a nearby captain...';

  @override
  String get stayOnline => 'Hang tight, we\'ll find you a captain shortly';

  @override
  String get captainOnWay => 'Your captain is on the way';

  @override
  String get captainArrived => 'Your captain has arrived';

  @override
  String get findCarByPlate => 'Look for the car by its plate number';

  @override
  String get call => 'Call';

  @override
  String get message => 'Message';

  @override
  String get rideCancelled => 'Ride cancelled';

  @override
  String get captainDeclined =>
      'Your captain declined the ride, please try again';

  @override
  String get arrivedSafely => 'You arrived safely';

  @override
  String get haveAGoodTrip => 'Have a good trip';

  @override
  String get howWasYourRide => 'How was your ride?';

  @override
  String get writeNotesOptional => 'Add a note (optional)';

  @override
  String get backToHome => 'Back to home';

  @override
  String get rideDetails => 'Ride details';

  @override
  String get waselDriverName => 'Wasel driver';

  @override
  String get noRideToRate => 'There is no ride to rate';

  @override
  String get noRideToCancel => 'There is no ride to cancel';

  @override
  String get cancelRideFailed =>
      'We could not cancel the ride, please try again';

  @override
  String get cannotCancelInProgress =>
      'You cannot cancel a ride that has already started';

  @override
  String get cardDetails => 'Card details';

  @override
  String get cardNumber => 'Card number';

  @override
  String get enterCardNumber => 'Enter your card number';

  @override
  String get cardNumberLength => 'Card number must be 16 digits';

  @override
  String get expiryDate => 'Expiry date';

  @override
  String get enterExpiryDate => 'Enter the expiry date';

  @override
  String get expiryFormat => 'Use the MM/YY format';

  @override
  String get invalidMonth => 'Invalid month';

  @override
  String get cardExpired => 'This card has expired';

  @override
  String get enterCvv => 'Enter the security code';

  @override
  String get cvvLength => '3 to 4 digits';

  @override
  String get saveCard => 'Save card';

  @override
  String captainEtaMinutes(String minutes) {
    return 'Your captain arrives in $minutes min';
  }

  @override
  String arrivalEtaMinutes(String minutes) {
    return 'Arriving in about $minutes min';
  }
}
