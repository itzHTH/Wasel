import 'package:driver/features/driver_verification/domain/entities/submit_driver_profile.dart';

sealed class SubmitProfileState {
  const SubmitProfileState();
}

final class SubmitUploading extends SubmitProfileState {
  final double progress;

  const SubmitUploading(this.progress);
}

final class SubmitSuccess extends SubmitProfileState {
  final SubmitDriverProfile result;

  const SubmitSuccess(this.result);
}

final class SubmitFailure extends SubmitProfileState {
  final String message;

  const SubmitFailure(this.message);
}
