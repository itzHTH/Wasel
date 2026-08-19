import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/data/models/request_ride/request/request_ride_body.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/selected_payment_method_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_price/ride_price_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_use_case_providers.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/api_error_message.dart';
import 'package:wasel_payments/core/policies/payment_eligibility_policy.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:wasel_payments/presentation/providers/tokenize/tokenize_card_provider.dart';
import 'package:wasel_payments/presentation/providers/wallet/rider_wallet_balance_provider.dart';

part 'request_ride_provider.g.dart';

@riverpod
class RequestRideController extends _$RequestRideController {
  @override
  FutureOr<RequestRide?> build() {
    return null;
  }

  Future<void> requetsRide() async {
    final draft = ref.read(rideDraftProvider);
    final pickup = draft.pickup;
    final dropoff = draft.dropoff;
    if (pickup == null || dropoff == null) return;

    final method = ref.read(selectedPaymentMethodProvider);
    final token = ref.read(tokenizeCardControllerProvider).value;

    state = const AsyncValue.loading();

    final blocker = await _blockerFor(method, token);
    if (!ref.mounted) return;
    if (blocker != null) {
      state = AsyncValue.error(blocker, StackTrace.current);
      return;
    }

    final useCase = ref.read(requestRideUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(
      RequestRideBody(
        geoPointRequest: GeoPointRequestBody(
          pickupLat: pickup.latitude.toString(),
          pickupLng: pickup.longitude.toString(),
          dropoffLat: dropoff.latitude.toString(),
          dropoffLng: dropoff.longitude.toString(),
        ),
        paymentMethod: method.code ?? PaymentMethod.cash.code!,
        paymentToken: method == PaymentMethod.card ? token : null,
      ),
    );

    if (!ref.mounted) return;

    result.when(
      failure: (error) {
        state = AsyncValue.error(
          error.apiErrorModel.displayMessage ?? "حصل خطأ ما",
          StackTrace.current,
        );
      },
      success: (price) {
        state = AsyncValue.data(price);
      },
    );
  }

  Future<String?> _blockerFor(PaymentMethod method, String? token) async {
    double? balance;
    if (method == PaymentMethod.wallet) {
      try {
        balance = (await ref.read(
          riderWalletBalanceControllerProvider.future,
        )).balance;
      } catch (_) {
        balance = null;
      }
    }

    return PaymentEligibilityPolicy.blockerFor(
      method: method,
      token: token,
      balance: balance,
      fare: ref.read(ridePriceEstimateProvider).value?.estimatedPrice,
    );
  }
}
