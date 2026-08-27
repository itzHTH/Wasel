import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/widgets/ride_search/endpoint_field.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_location/wasel_location.dart';

/// The search header: a back button, then both endpoints grouped into one well
/// and joined by the rail that mirrors the map's markers.
class RideSearchHeader extends StatelessWidget {
  static const heroTag = 'ride-search-header';

  const RideSearchHeader({
    super.key,
    required this.pickup,
    required this.dropoff,
    required this.activeField,
    required this.onQueryChanged,
    required this.onSubmitted,
    required this.onCleared,
    required this.pickupIsResolving,
    required this.dropoffLocked,
    required this.onBlockedDropoffTap,
    required this.onBack,
  });

  final EndpointField pickup;
  final EndpointField dropoff;
  final SearchFieldType activeField;

  final void Function(SearchFieldType, String) onQueryChanged;
  final void Function(SearchFieldType, String) onSubmitted;
  final void Function(SearchFieldType) onCleared;

  final bool pickupIsResolving;
  final bool dropoffLocked;
  final VoidCallback onBlockedDropoffTap;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    return Hero(
      tag: heroTag,
      child: Material(
        color: colors.elementBackground,
        // A hairline rather than a shadow: in dark mode the header and the
        // page sit at nearly the same value, and a shadow reads as nothing.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(context.shape.radiusSheet),
          ),
          side: BorderSide(color: colors.neutral100),
        ),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppDimens.space8,
              AppDimens.space4,
              AppDimens.space16,
              AppDimens.space16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: colors.secondary900,
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                ),
                Padding(
                  padding: EdgeInsets.only(left: AppDimens.space8),
                  child: _EndpointGroup(
                    pickup: _EndpointRow(
                      field: pickup,
                      hintText: l10n.pickupLabel,
                      isActive: activeField.isPickup,
                      isResolvingLabel: pickupIsResolving,
                      onQueryChanged: onQueryChanged,
                      onSubmitted: onSubmitted,
                      onCleared: onCleared,
                    ),
                    dropoff: _EndpointRow(
                      field: dropoff,
                      hintText: l10n.destinationLabel,
                      isActive: !activeField.isPickup,
                      readOnly: dropoffLocked,
                      onBlockedTap: onBlockedDropoffTap,
                      onQueryChanged: onQueryChanged,
                      onSubmitted: onSubmitted,
                      onCleared: onCleared,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One endpoint's field, wired to its own search controller.
class _EndpointRow extends ConsumerWidget {
  const _EndpointRow({
    required this.field,
    required this.hintText,
    required this.isActive,
    required this.onQueryChanged,
    required this.onSubmitted,
    required this.onCleared,
    this.isResolvingLabel = false,
    this.readOnly = false,
    this.onBlockedTap,
  });

  final EndpointField field;
  final String hintText;
  final bool isActive;
  final void Function(SearchFieldType, String) onQueryChanged;
  final void Function(SearchFieldType, String) onSubmitted;
  final void Function(SearchFieldType) onCleared;
  final bool isResolvingLabel;
  final bool readOnly;
  final VoidCallback? onBlockedTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusy = ref.watch(
      placeSearchControllerProvider(
        field.type,
      ).select((state) => state.isSearching),
    );

    return PlaceSearchField(
      controller: field.controller,
      focusNode: field.focusNode,
      hintText: hintText,
      marker: EndpointMarker(isPickup: field.isPickup, isActive: isActive),
      isBusy: isBusy,
      isResolvingLabel: isResolvingLabel,
      readOnly: readOnly,
      onBlockedTap: onBlockedTap,
      textInputAction: TextInputAction.search,
      onChanged: (value) => onQueryChanged(field.type, value),
      onSubmitted: (value) => onSubmitted(field.type, value),
      onCleared: () => onCleared(field.type),
    );
  }
}

/// Both fields in one well, with a single unbroken line running from the
/// pickup dot to the drop-off square.
class _EndpointGroup extends StatelessWidget {
  const _EndpointGroup({required this.pickup, required this.dropoff});

  final Widget pickup;
  final Widget dropoff;

  static const double _railWidth = 2;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.screenBackground,
        borderRadius: BorderRadius.circular(context.shape.radiusCard),
        border: Border.all(color: colors.neutral100),
      ),
      padding: EdgeInsets.all(AppDimens.space4),
      child: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            bottom: 0,
            start: PlaceSearchField.markerInset,
            width: PlaceSearchField.markerGutter,
            child: Center(
              child: FractionallySizedBox(
                heightFactor: 0.5,
                child: Container(
                  width: _railWidth,
                  decoration: BoxDecoration(
                    color: colors.neutral400,
                    borderRadius: BorderRadius.circular(_railWidth),
                  ),
                ),
              ),
            ),
          ),
          Column(mainAxisSize: MainAxisSize.min, children: [pickup, dropoff]),
        ],
      ),
    );
  }
}
