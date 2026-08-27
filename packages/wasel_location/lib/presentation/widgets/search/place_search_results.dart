import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_entrance_fade.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_location/domain/entities/place_suggestion.dart';
import 'package:wasel_location/l10n/location_l10n_extension.dart';
import 'package:wasel_location/presentation/providers/search/place_search_controller.dart';
import 'package:wasel_location/presentation/providers/search/place_search_state.dart';
import 'package:wasel_location/presentation/providers/search/search_field_type.dart';
import 'package:wasel_location/presentation/widgets/search/place_search_action_row.dart';
import 'package:wasel_location/presentation/widgets/search/place_search_message.dart';
import 'package:wasel_location/presentation/widgets/search/place_suggestion_tile.dart';

/// The result area beneath the search fields.
///
/// Renders exactly one of four states — prompt, loading, error, results —
/// cross-faded so the panel never blinks between keystrokes.
///
//! Watches [placeSearchControllerProvider] unconditionally, which is what
//! keeps the auto-disposed controller (and its debouncer) alive between
//! keystrokes. Reading it only on tap would fire a request per character.
class PlaceSearchResults extends ConsumerStatefulWidget {
  const PlaceSearchResults({
    super.key,
    required this.field,
    required this.onSelected,
    this.onUseCurrentLocation,
    this.resolvingId,
  });

  final SearchFieldType field;
  final ValueChanged<PlaceSuggestion> onSelected;

  /// Offered above the prompt, where it saves the commonest search outright.
  /// Omitted when the host has no position to offer.
  final VoidCallback? onUseCurrentLocation;

  /// The suggestion whose coordinates are being fetched, if any.
  final String? resolvingId;

  @override
  ConsumerState<PlaceSearchResults> createState() => _PlaceSearchResultsState();
}

class _PlaceSearchResultsState extends ConsumerState<PlaceSearchResults> {
  _Phase? _phase;

  //! Counts phase changes, and is the switcher's key. Keying by the phase
  //! itself crashes: AnimatedSwitcher matches a new child only against the
  //! current entry, never the outgoing ones, so returning to a phase inside
  //! the 220ms fade stacks two subtrees under one key. Typing in one field
  //! and switching to the other reaches that in well under 220ms.
  var _generation = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(placeSearchControllerProvider(widget.field));

    final phase = _phaseOf(state);
    if (phase != _phase) {
      _phase = phase;
      _generation++;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      layoutBuilder: (current, previous) => Stack(
        alignment: Alignment.topCenter,
        children: [...previous, if (current != null) current],
      ),
      child: KeyedSubtree(
        key: ValueKey(_generation),
        child: _body(context, ref, state),
      ),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref, PlaceSearchState state) {
    switch (_phaseOf(state)) {
      case _Phase.prompt:
        final useCurrentLocation = widget.onUseCurrentLocation;
        return Column(
          children: [
            if (useCurrentLocation != null) ...[
              SizedBox(height: AppDimens.space8),
              PlaceSearchActionRow(
                icon: Icons.my_location_rounded,
                label: context.locationL10n.currentLocation,
                onTap: useCurrentLocation,
              ),
            ],
            Expanded(
              child: PlaceSearchMessage(
                icon: Icons.search_rounded,
                title: context.locationL10n.searchPromptTitle,
                message: context.locationL10n.searchPromptMessage,
              ),
            ),
          ],
        );

      case _Phase.loading:
        return const _SuggestionSkeletons();

      case _Phase.error:
        return PlaceSearchMessage(
          icon: Icons.wifi_off_rounded,
          tone: context.colors.alertError500,
          title: context.locationL10n.searchFailedTitle,
          message: errorMessageOf(state.searchError!),
          action: TextButton.icon(
            onPressed: () => ref
                .read(placeSearchControllerProvider(widget.field).notifier)
                .submit(state.query),
            icon: const Icon(Icons.refresh_rounded),
            label: Text(context.coreL10n.retry),
          ),
        );

      case _Phase.empty:
        return PlaceSearchMessage(
          icon: Icons.location_off_rounded,
          title: context.locationL10n.searchNoResultsTitle,
          message: context.locationL10n.searchNoResultsMessage,
        );

      case _Phase.results:
        return _SuggestionList(
          suggestions: state.suggestions,
          onSelected: widget.onSelected,
          resolvingId: widget.resolvingId,
        );
    }
  }

  /// Loading only takes over the panel when there is nothing to keep showing —
  /// otherwise the previous results stay put and the field's own spinner
  /// carries the progress, so the list does not flicker on every keystroke.
  static _Phase _phaseOf(PlaceSearchState state) {
    if (state.suggestions.isNotEmpty) return _Phase.results;
    if (state.isSearching) return _Phase.loading;
    if (state.searchError != null) return _Phase.error;
    if (state.query.isEmpty) return _Phase.prompt;
    return _Phase.empty;
  }
}

enum _Phase { prompt, loading, error, empty, results }

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({
    required this.suggestions,
    required this.onSelected,
    required this.resolvingId,
  });

  final List<PlaceSuggestion> suggestions;
  final ValueChanged<PlaceSuggestion> onSelected;
  final String? resolvingId;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.locationL10n.searchResultsLabel,
      container: true,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: AppDimens.space8),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: suggestions.length,
        separatorBuilder: (_, _) => const _HairlineDivider(),
        itemBuilder: (context, index) => AppEntranceFade(
          index: index,
          child: PlaceSuggestionTile(
            suggestion: suggestions[index],
            onTap: onSelected,
            isResolving: suggestions[index].id == resolvingId,
          ),
        ),
      ),
    );
  }
}

/// Skeleton rows shaped like [PlaceSuggestionTile], so the panel keeps its
/// rhythm and nothing shifts when the real results replace them.
class _SuggestionSkeletons extends StatelessWidget {
  const _SuggestionSkeletons();

  static const _rowCount = 5;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: AppSkeleton(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: AppDimens.space8),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _rowCount,
          separatorBuilder: (_, _) => const _HairlineDivider(),
          itemBuilder: (context, index) => PlaceSuggestionTile(
            suggestion: PlaceSuggestion(
              id: 'skeleton-$index',
              // Varying widths so the block reads as text, not as a bar chart.
              name: index.isEven ? 'شارع الرشيد الرئيسي' : 'الكرادة الشرقية',
              addressParts: index.isEven
                  ? const ['بغداد']
                  : const ['الرصافة', 'بغداد'],
            ),
            onTap: (_) {},
          ),
        ),
      ),
    );
  }
}

class _HairlineDivider extends StatelessWidget {
  const _HairlineDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.space12),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: context.colors.neutral100,
      ),
    );
  }
}
