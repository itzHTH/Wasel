import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/ride/ride_search_radar.dart';

/// Every stage a trip passes through, on either side of the platform. The
/// rider's `RideStage` and `PickingStage` and the captain's `DriverStage` each
/// map onto a subset; this is the one place a stage is turned into a picture.
enum RideStageVisual {
  choosingPickup,
  choosingDropoff,
  reviewingTrip,
  searching,
  offline,
  connecting,
  offerReceived,
  accepted,
  arrived,
  inTrip,
  completed,
  cancelled,
}

extension RideStageVisualIcon on RideStageVisual {
  /// The radar replaces this while [RideStageVisual.searching] is on screen;
  /// it stands in wherever a static glyph is needed.
  IconData get icon => switch (this) {
    RideStageVisual.choosingPickup => Icons.my_location_rounded,
    RideStageVisual.choosingDropoff => Icons.flag_rounded,
    RideStageVisual.reviewingTrip => Icons.fact_check_rounded,
    RideStageVisual.searching => Icons.radar_rounded,
    RideStageVisual.offline => Icons.power_settings_new_rounded,
    RideStageVisual.connecting => Icons.wifi_tethering_rounded,
    RideStageVisual.offerReceived => Icons.notifications_active_rounded,
    RideStageVisual.accepted => Icons.directions_car_rounded,
    RideStageVisual.arrived => Icons.check_circle_rounded,
    RideStageVisual.inTrip => Icons.navigation_rounded,
    RideStageVisual.completed => Icons.check_rounded,
    RideStageVisual.cancelled => Icons.cancel_rounded,
  };
}

enum _Tone {
  brand,
  success,
  neutral,
  danger;

  Color background(BuildContext context) => switch (this) {
    _Tone.brand => context.colors.primary100,
    _Tone.success => context.colors.alertSuccess100,
    _Tone.neutral => context.colors.neutral100,
    _Tone.danger => context.colors.alertError100,
  };

  Color foreground(BuildContext context) => switch (this) {
    _Tone.brand => context.colors.primary500,
    _Tone.success => context.colors.alertSuccess500,
    _Tone.neutral => context.colors.neutral400,
    _Tone.danger => context.colors.alertError500,
  };
}

_Tone _toneFor(RideStageVisual stage) => switch (stage) {
  RideStageVisual.offline => _Tone.neutral,
  RideStageVisual.arrived || RideStageVisual.completed => _Tone.success,
  RideStageVisual.cancelled => _Tone.danger,
  _ => _Tone.brand,
};

/// The trip's status, drawn as an icon in a tinted rounded container. Both the
/// glyph and the tint follow [stage], and both cross-fade when it changes, so a
/// card that outlives a stage change updates in place rather than cutting.
class RideStageBadge extends StatelessWidget {
  const RideStageBadge({super.key, required this.stage, this.size});

  final RideStageVisual stage;

  /// Defaults to the inline size the card headers use. Pass a larger box for
  /// the standalone badge a terminal card centres.
  final double? size;

  static const _swap = Duration(milliseconds: 260);

  @override
  Widget build(BuildContext context) {
    final box = size ?? AppDimens.icon40;
    final tone = _toneFor(stage);

    final radius = context.shape.badgeRadiusFor(box);

    return AnimatedContainer(
      duration: _swap,
      curve: Curves.easeOut,
      width: box,
      height: box,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tone.background(context),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: AnimatedSwitcher(
        duration: _swap,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: Tween<double>(begin: 0.7, end: 1).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: stage == RideStageVisual.searching
            ? RideSearchRadar(
                key: const ValueKey(RideStageVisual.searching),
                size: box * 0.7,
                color: tone.foreground(context),
              )
            : Icon(
                stage.icon,
                key: ValueKey(stage),
                size: box / 2,
                color: tone.foreground(context),
              ),
      ),
    );
  }
}
