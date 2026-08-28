// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'driver_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class DriverLocalizationsEn extends DriverLocalizations {
  DriverLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get brandName => 'Wasel Driver';

  @override
  String get authHeaderTagline => 'Join the fleet at ';

  @override
  String get loginTagline => 'Log in as a driver';

  @override
  String get registerTagline => 'Create a driver account';

  @override
  String get city => 'City';

  @override
  String get enterCity => 'Enter your city';

  @override
  String get address => 'Address';

  @override
  String get enterAddress => 'Enter your address';

  @override
  String get myAccount => 'My account';

  @override
  String get profileDetails => 'Profile';

  @override
  String get rideHistory => 'Ride history';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirmMessage =>
      'Are you sure you want to log out of your account?';

  @override
  String get todayEarnings => 'Today\'s earnings';

  @override
  String get todayRides => 'Today\'s rides';

  @override
  String get todayOnlineTime => 'Online time today';

  @override
  String get rating => 'Rating';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get youAreOffline => 'You\'re offline';

  @override
  String get noRequestsWhileOffline => 'You won\'t get requests while offline';

  @override
  String get startAcceptingRides => 'Start accepting rides';

  @override
  String get stopAcceptingRides => 'Stop accepting';

  @override
  String get stayInBusyArea => 'Stay in a busy area to get more requests';

  @override
  String get searchingForRequests => 'Looking for requests';

  @override
  String get connecting => 'Connecting...';

  @override
  String get connectingToServer => 'Connecting to the server';

  @override
  String get reconnecting => 'Reconnecting...';

  @override
  String get oneMomentConnecting => 'One moment, finishing the connection';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get serverDisconnected => 'Lost connection to the server';

  @override
  String get noServerConnection =>
      'No server connection, your location isn\'t reaching dispatch';

  @override
  String get noServerResponse => 'No response from the server, try again';

  @override
  String get checkYourConnection =>
      'Check your internet connection and try again.';

  @override
  String get locationServiceOffDriver =>
      'Location services are off. Turn them on so we can send your location.';

  @override
  String get cannotSendLocation =>
      'We can\'t send your location without permission';

  @override
  String get cannotDetermineLocation =>
      'We can\'t fix your location, check your GPS signal';

  @override
  String get cannotDrawRoute => 'We can\'t draw the route';

  @override
  String get noLocationNoRoute => 'No location, so we can\'t draw the route';

  @override
  String get newRequest => 'New request';

  @override
  String get requestReceived => 'Request received';

  @override
  String get acceptRequest => 'Accept request';

  @override
  String get onWayToPickup => 'On the way to pickup';

  @override
  String get onWayToRider => 'On the way to the rider';

  @override
  String get arrivedAtPickup => 'Arrived at pickup';

  @override
  String get arrived => 'Arrived';

  @override
  String get waitingForRider => 'Waiting for the rider';

  @override
  String get waitForRiderThenStart =>
      'Wait for the rider to get in, then start the ride';

  @override
  String get startRide => 'Start ride';

  @override
  String get rideInProgress => 'Ride in progress';

  @override
  String get rideOngoing => 'Ongoing ride';

  @override
  String get endRide => 'End ride';

  @override
  String get rideFinished => 'Ride finished';

  @override
  String get cancelRide => 'Cancel ride';

  @override
  String get backToRequests => 'Back to requests';

  @override
  String get pickupPoint => 'Pickup';

  @override
  String get dropoffPoint => 'Destination';

  @override
  String get collectFareFromRider => 'Collect the fare from the rider';

  @override
  String get switchToCash => 'Switch to cash';

  @override
  String get switchToCashConfirm => 'Switch this ride to cash and finish it?';

  @override
  String get paymentCollectFailed => 'We couldn\'t collect the payment';

  @override
  String get statusUpdateFailed => 'We couldn\'t update the status, try again.';

  @override
  String get phoneUnavailable => 'Phone number unavailable';

  @override
  String get waselDriverName => 'Wasel driver';

  @override
  String get driverVerification => 'Driver verification';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Back';

  @override
  String get personalPhoto => 'Profile photo';

  @override
  String get selfiePhoto => 'Selfie';

  @override
  String get takeClearSelfie => 'Take a clear selfie so we can match your ID.';

  @override
  String get placeFaceInFrame => 'Put your face inside the frame';

  @override
  String get driverLicense => 'Driver\'s licence';

  @override
  String get licenseFront => 'Front of licence';

  @override
  String get licenseBack => 'Back of licence';

  @override
  String get photographLicense =>
      'Photograph the front and back of your licence inside the frame.';

  @override
  String get placeLicenseInFrame => 'Put the licence inside the frame';

  @override
  String get vehicleData => 'Vehicle details';

  @override
  String get vehiclePhoto => 'Vehicle photo';

  @override
  String get photographVehicle =>
      'Photograph your vehicle and enter its details.';

  @override
  String get placeVehicleInFrame => 'Put the vehicle inside the frame';

  @override
  String get vehicleModel => 'Vehicle model';

  @override
  String get vehicleModelExample => 'e.g. Toyota Corolla';

  @override
  String get manufactureYear => 'Year';

  @override
  String get manufactureYearExample => 'e.g. 2020';

  @override
  String get plateNumber => 'Plate number';

  @override
  String get plateNumberExample => '234244 C / 342134 B';

  @override
  String get capture => 'Capture';

  @override
  String get captureWithCamera => 'Use the camera';

  @override
  String get chooseFromGalleryDriver => 'Choose from gallery';

  @override
  String get retake => 'Retake';

  @override
  String get confirmPhoto => 'Use this photo';

  @override
  String get ensurePhotoClear =>
      'Make sure the photo is clear and readable before continuing.';

  @override
  String get captureFailed => 'Couldn\'t capture, try again';

  @override
  String get cameraStartFailed => 'We couldn\'t start the camera';

  @override
  String get noCameraAvailable => 'No camera available';

  @override
  String get cameraPermissionRequired => 'Camera permission required';

  @override
  String get cameraPermissionMessage =>
      'We need camera permission to take the photo. Enable it in Settings.';

  @override
  String get uploadingDocuments => 'Uploading your documents…';

  @override
  String get documentsUploaded => 'Documents uploaded';

  @override
  String get uploadFailed => 'We couldn\'t upload your documents';

  @override
  String get pleaseWaitDontClose => 'Please wait and don\'t close the app.';

  @override
  String get backToForm => 'Back to the form';

  @override
  String get discard => 'Discard';

  @override
  String get underReview => 'Under review';

  @override
  String get pendingStatus => 'Pending';

  @override
  String get approved => 'Verified';

  @override
  String get rejected => 'Rejected';

  @override
  String get requestUnderReview => 'Your application is under review';

  @override
  String get reviewingDocuments =>
      'We\'re reviewing your documents, which usually takes up to 24 hours.';

  @override
  String get willNotifyResult =>
      'We\'ll review your application and let you know the result.';

  @override
  String get stillUnderReview =>
      'Your application is still under review, we\'ll tell you as soon as it changes.';

  @override
  String get previousRequestRejected =>
      'Your previous application was rejected. Please review your details and resubmit.';

  @override
  String get infoRejected =>
      'Your details were rejected. Please review them and resubmit.';

  @override
  String get statusCheckFailed => 'We couldn\'t check your application status';

  @override
  String get verifyingAccount => 'Verifying your account and details…';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get profileLoadFailed => 'We couldn\'t load your profile';

  @override
  String get balance => 'Balance';

  @override
  String get edit => 'Edit';

  @override
  String get editPhoneOnlyDriver =>
      'You can only change your phone number. Contact support to update your name or vehicle details.';

  @override
  String get currencyIqd => 'IQD';

  @override
  String riderEtaMinutes(String minutes) {
    return 'Arriving in $minutes min';
  }

  @override
  String distanceKm(String value) {
    return '$value km';
  }

  @override
  String coordinatePair(String lat, String lng) {
    return '$lat, $lng';
  }

  @override
  String durationHoursMinutes(String hours, String minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String durationHours(String hours) {
    return '${hours}h';
  }

  @override
  String durationMinutes(String minutes) {
    return '${minutes}m';
  }

  @override
  String get earnings => 'Earnings';

  @override
  String get totalEarnings => 'Total earnings';

  @override
  String get periodToday => 'Today';

  @override
  String get periodLast7Days => 'Last 7 days';

  @override
  String get periodLast30Days => 'Last 30 days';

  @override
  String get completedRidesLabel => 'Completed rides';

  @override
  String get onlineTimeLabel => 'Online time';

  @override
  String get cashOut => 'Cash out';

  @override
  String get cashOutUnavailableHint =>
      'You have no earnings available to cash out right now.';

  @override
  String get cashOutSoonTitle => 'Cash out coming soon';

  @override
  String get cashOutSoonMessage =>
      'Transferring your earnings to your account is on the way — we\'ll let you know the moment it\'s ready.';

  @override
  String get restoringRide => 'Setting up your connection';

  @override
  String get shiftChannelName => 'Driver shift';

  @override
  String get shiftOnlineTitle => 'Online';

  @override
  String get shiftOnlineBody => 'Waiting for ride requests';

  @override
  String get shiftOnTripTitle => 'On a trip';

  @override
  String get shiftOnTripBody => 'Sharing your location with the rider';

  @override
  String get shiftReconnectingTitle => 'Reconnecting';

  @override
  String get shiftReconnectingBody =>
      'You won\'t get requests until the connection is back';

  @override
  String get notificationsRequiredForShift =>
      'Turn on notifications so requests reach you outside the app';
}
