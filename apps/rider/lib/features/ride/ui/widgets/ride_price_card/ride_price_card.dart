import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_price/ride_price_provider.dart';
import 'package:wasal/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_price_error_view.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_price_loading.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_price_view.dart';
import 'package:wasel_core/wasel_core.dart';

class RidePriceCard extends ConsumerStatefulWidget {
  const RidePriceCard({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  ConsumerState<RidePriceCard> createState() => _RidePriceCardState();
}

class _RidePriceCardState extends ConsumerState<RidePriceCard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      ref.read(ridePriceEstimateProvider.notifier).getPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    final priceState = ref.watch(ridePriceEstimateProvider);

    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: AppDimens.space8),
                child: IconButton(
                  onPressed: widget.onClose,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColor.neutral100,
                  ),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColor.secondary900,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'تفاصيل الرحلة',
                  style: AppTextStyles.font20Secondary900Bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          priceState.when(
            loading: () => const RidePriceLoading(),
            error: (error, _) => RidePriceErrorView(message: '$error'),
            data: (price) => price == null
                ? const RidePriceLoading()
                : RidePriceView(price: price),
          ),
        ],
      ),
    );
  }
}
