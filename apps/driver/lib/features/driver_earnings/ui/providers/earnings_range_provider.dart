import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earnings_range_provider.g.dart';

@riverpod
class EarningsRangeController extends _$EarningsRangeController {
  @override
  EarningsRange build() => EarningsRange.today;

  void select(EarningsRange range) => state = range;
}
