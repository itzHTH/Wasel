import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/widgets/ride_search/endpoint_field.dart';
import 'package:wasal/features/ride/ui/widgets/ride_search/place_search_selection.dart';
import 'package:wasal/features/ride/ui/widgets/ride_search/ride_search_header.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_location/wasel_location.dart';

export 'package:wasal/features/ride/ui/widgets/ride_search/place_search_selection.dart';

/// Full-screen place search for a ride's two endpoints.
class RideSearchScreen extends ConsumerStatefulWidget {
  const RideSearchScreen({
    super.key,
    this.initialField = SearchFieldType.dropoff,
    this.pickupLabel,
    this.proximity,
    this.hasPickup = false,
    this.pickupIsResolving = false,
  });

  /// Which field takes focus on open. Tapping "where to?" opens on drop-off;
  /// tapping the pickup row opens on pickup.
  final SearchFieldType initialField;

  /// Pre-fills the pickup field. When null the screen resolves the rider's
  /// current location itself, so the common case needs no typing at all.
  final String? pickupLabel;

  /// Biases results toward the rider, usually the map's centre. When null the
  /// screen falls back to the rider's last known position.
  final GeoPoint? proximity;

  /// Whether the draft already holds a pinned pickup. Drop-off is unavailable
  /// until it does — a destination means nothing without an origin, and text
  /// sitting in the pickup field is not one.
  final bool hasPickup;

  /// A pickup is already pinned and only its name is still being looked up.
  /// The endpoint is answered, so drop-off stays open and the field shimmers
  /// rather than reading as blank.
  final bool pickupIsResolving;

  @override
  ConsumerState<RideSearchScreen> createState() => _RideSearchScreenState();
}

class _RideSearchScreenState extends ConsumerState<RideSearchScreen> {
  final _pickup = EndpointField(SearchFieldType.pickup);
  final _dropoff = EndpointField(SearchFieldType.dropoff);

  //! Addressed by key, never `ScaffoldMessenger.of(context)`. `of` walks
  //! ancestors, and the messenger below is this State's own descendant — so
  //! `of` finds the app's messenger instead and posts the snackbar to the ride
  //! screen, behind this opaque route, where the rider never sees it.
  final _messenger = GlobalKey<ScaffoldMessengerState>();

  late SearchFieldType _activeField = widget.initialField;

  /// Set once the rider edits pickup themselves. After that the resolved
  /// current location must not overwrite what they typed.
  bool _pickupTouched = false;

  /// The suggestion whose coordinates are in flight. Also the double-tap
  /// guard: a second tap while one is resolving is ignored.
  String? _resolvingId;

  @override
  void initState() {
    super.initState();
    _pickup.controller.text = widget.pickupLabel ?? '';
    _pickupTouched = widget.pickupLabel != null || widget.pickupIsResolving;

    for (final field in [_pickup, _dropoff]) {
      field.focusNode.addListener(() {
        if (field.focusNode.hasFocus) {
          setState(() => _activeField = field.type);
        }
      });
    }

    // Listened, not watched: this only writes into a controller, and watching
    // would rebuild the screen for a value the field already holds.
    ref.listenManual(
      currentLocationLabelProvider,
      (_, _) => _prefillPickup(),
      fireImmediately: true,
    );
    ref.listenManual(
      lastKnownLocationProvider,
      (_, _) => _prefillPickup(),
      fireImmediately: true,
    );

    // Autofocus after the entrance transition, so the keyboard does not race
    // the slide-in and jank the first frames.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _fieldFor(_activeField).focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pickup.dispose();
    _dropoff.dispose();
    super.dispose();
  }

  /// A ride needs an origin before a destination means anything, and a
  /// drop-off chosen first would be silently discarded by the chaining above.
  void _warnPickupFirst() {
    _pickup.focusNode.requestFocus();
    _notify(context.locationL10n.pickupRequiredFirst);
  }

  EndpointField _fieldFor(SearchFieldType type) =>
      type.isPickup ? _pickup : _dropoff;

  /// Fills pickup with the resolved current location, unless the rider has
  /// already started editing it.
  void _prefillPickup() {
    if (_pickupTouched || !_pickup.isBlank) return;
    if (ref.read(lastKnownLocationProvider).value == null) return;

    final label = ref.read(currentLocationLabelProvider).value;
    if (label == null) return;

    _pickup.controller.text = label;
  }

  /// The caller's bias when given, otherwise wherever the rider last was.
  GeoPoint? get _proximity =>
      widget.proximity ?? ref.read(lastKnownLocationProvider).value;

  void _onQueryChanged(SearchFieldType field, String value) {
    if (field.isPickup) _pickupTouched = true;
    ref
        .read(placeSearchControllerProvider(field).notifier)
        .onQueryChanged(value, proximity: _proximity);
  }

  void _onSubmitted(SearchFieldType field, String value) {
    ref.read(placeSearchControllerProvider(field).notifier).submit(value);
  }

  void _onCleared(SearchFieldType type) {
    // Emptying pickup on purpose counts as editing it, or the current-location
    // label lands a moment later and fills the field back in.
    if (type.isPickup) _pickupTouched = true;

    final field = _fieldFor(type)..controller.clear();
    ref.read(placeSearchControllerProvider(type).notifier).clear();
    field.focusNode.requestFocus();
  }

  /// Selects wherever the rider is standing, so the commonest pickup needs no
  /// typing. Null-safe by construction: the row is only offered once a
  /// position and a label both exist.
  ///
  void _useCurrentLocation() {
    final point = ref.read(lastKnownLocationProvider).value;
    final label = ref.read(currentLocationLabelProvider).value;
    if (point == null || label == null) return;

    _commit(PickedPlace(name: label, point: point));
  }

  /// Autocomplete carries no coordinates, so the point is fetched only for the
  /// one suggestion the rider actually tapped.
  Future<void> _onSelected(PlaceSuggestion suggestion) async {
    if (_resolvingId != null) return;
    setState(() => _resolvingId = suggestion.id);

    final result = await ref
        .read(retrievePlaceUseCaseProvider)
        .call(
          RetrievePlaceParams(
            placeId: suggestion.id,
            languageCode: Localizations.localeOf(context).languageCode,
          ),
        );

    if (!mounted) return;
    setState(() => _resolvingId = null);

    result.when(
      success: (point) =>
          _commit(PickedPlace(name: suggestion.name, point: point)),
      failure: (error) => _notify(errorMessageOf(error)),
    );
  }

  void _notify(String message) {
    _messenger.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  /// Hands the choice back and closes.
  void _commit(PickedPlace place) {
    final field = _fieldFor(_activeField);
    field.controller.text = place.name;
    if (field.isPickup) _pickupTouched = true;

    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).pop((finalPick: place, finalField: field.type));
  }

  /// Whether to offer "use my current location".
  bool get _canUseCurrentLocation =>
      _activeField.isPickup &&
      ref.watch(lastKnownLocationProvider).value != null &&
      ref.watch(currentLocationLabelProvider).value != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Its own messenger: this route is transparent, so the ride screen's
    // Scaffold stays mounted underneath and the app-level messenger would
    // render every snackbar into both of them.
    return ScaffoldMessenger(
      key: _messenger,
      child: Scaffold(
        backgroundColor: colors.screenBackground,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              RideSearchHeader(
                pickup: _pickup,
                dropoff: _dropoff,
                activeField: _activeField,
                onQueryChanged: _onQueryChanged,
                onSubmitted: _onSubmitted,
                onCleared: _onCleared,
                pickupIsResolving: widget.pickupIsResolving,
                dropoffLocked: !widget.hasPickup,
                onBlockedDropoffTap: _warnPickupFirst,
                onBack: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: PlaceSearchResults(
                  field: _activeField,
                  onSelected: _onSelected,
                  resolvingId: _resolvingId,
                  onUseCurrentLocation: _canUseCurrentLocation
                      ? _useCurrentLocation
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
