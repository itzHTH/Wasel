// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AuthLocalizationsEn extends AuthLocalizations {
  AuthLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Log In';

  @override
  String get loggingIn => 'Logging in...';

  @override
  String get loginSuccess => 'Logged in successfully';

  @override
  String get createAccount => 'Create Account';

  @override
  String get registerSuccess => 'Registered successfully';

  @override
  String get registerFormDescription =>
      'Enter your personal details to complete registration';

  @override
  String get completeYourInfo => 'Complete your details';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get firstName => 'First name';

  @override
  String get enterFirstName => 'Enter your first name';

  @override
  String get lastName => 'Last name';

  @override
  String get enterLastName => 'Enter your last name';

  @override
  String get email => 'Email';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get enterPhoneNumber => 'Enter your phone number';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter a password';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get reenterPassword => 'Re-enter your password';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get forgotPasswordDescription =>
      'Enter your email and we\'ll send you a verification code to reset your password';

  @override
  String get rememberedPassword => 'Remembered your password? ';

  @override
  String get newPasswordTitle => 'New password';

  @override
  String get chooseNewPassword => 'Choose a new password for your account';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get enterNewPassword => 'Enter your new password';

  @override
  String get reenterNewPassword => 'Re-enter your new password';

  @override
  String get passwordChangedSuccess => 'Password changed successfully';

  @override
  String get verificationCode => 'Verification code';

  @override
  String otpSentToEmail(String email) {
    return 'We sent a verification code to your email\n$email';
  }

  @override
  String get otpSentSuccess => 'Verification code sent to your email';

  @override
  String get sendCode => 'Send code';

  @override
  String get send => 'Send';

  @override
  String get requestNewCode => 'Request a new code';

  @override
  String get willNeedNewCode => 'You\'ll need to request a new code';

  @override
  String get confirm => 'Confirm';

  @override
  String get continueAction => 'Continue';

  @override
  String get cancelProcess => 'Cancel';

  @override
  String get confirmCancel => 'Are you sure you want to cancel?';

  @override
  String get otpExpired => 'Your code expired. Request a new one to continue.';
}
