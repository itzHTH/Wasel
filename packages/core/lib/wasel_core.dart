/// wasel_core — shared foundation for the Wasel apps.
///
/// Public surface: constants, flavors, helpers, networking (Dio/Retrofit
/// plumbing, results, error handling, interceptors), theming, base use cases,
/// shared widgets, and shared page transitions (route tables stay app-owned).
library;

// Constants
export 'const/app_constants.dart';

// Flavors
export 'flavors/flavors_config.dart';

// Extensions
export 'extensions/navigation_extension.dart';

// Helpers
export 'helpers/app_amount_format.dart';
export 'helpers/app_image_compressor.dart';
export 'helpers/app_image_picker.dart';
export 'helpers/app_local_cache.dart';
export 'helpers/app_navigation.dart';
export 'helpers/app_url_launcher.dart';
export 'helpers/app_validators.dart';
export 'helpers/session_store.dart';

// Localization
export 'l10n/core_localizations.dart';
export 'l10n/core_l10n_extension.dart';
export 'localization/app_local_type.dart';
export 'localization/providers/app_localization_provider.dart';

// Permissions
export 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionStatus, openAppSettings;
export 'permissions/permission_gate.dart';

// Networking
export 'networking/api_constants.dart';
export 'networking/api_results.dart';
export 'networking/base_response.dart';
export 'networking/dio/dio_factory.dart';
export 'networking/errors/api_error_message.dart';
export 'networking/errors/api_error_model.dart';
export 'networking/errors/api_error_reason.dart';
export 'networking/errors/error_handler.dart';
export 'networking/errors/error_message.dart';
export 'networking/interceptors/auth_interceptor.dart';
export 'networking/interceptors/localization_interceptor.dart';
export 'networking/json_num_converters.dart';
export 'networking/paged/paged_list.dart';
export 'networking/paged/paged_list_response.dart';
export 'networking/session_refresher.dart';

// Routing — shared transitions only; each app still owns its route table.
export 'routing/app_page_transitions.dart';

// Theme
export 'theme/app_brand.dart';
export 'theme/app_colors_extension.dart';
export 'theme/app_dimens.dart';
export 'theme/app_text_styles.dart';
export 'theme/app_theme.dart';
export 'theme/palettes/alert_tokens.dart';
export 'theme/palettes/driver_palette.dart';
export 'theme/palettes/rider_palette.dart';
export 'theme/providers/theme_mode_provider.dart';
export 'theme/theme_context_extension.dart';

// Use cases
export 'usecase/base_use_case.dart';
export 'usecase/cancellable_use_case.dart';
export 'usecase/stream_base_use_case.dart';

// Widgets
export 'widgets/app_appearance_sheet.dart';
export 'widgets/app_back_button.dart';
export 'widgets/app_dialog.dart';
export 'widgets/app_editable_avatar.dart';
export 'widgets/app_entrance_fade.dart';
export 'widgets/app_error_retry.dart';
export 'widgets/app_error_state.dart';
export 'widgets/app_group_card.dart';
export 'widgets/app_image_source_sheet.dart';
export 'widgets/app_info_row.dart';
export 'widgets/app_inline_error.dart';
export 'widgets/app_language_sheet.dart';
export 'widgets/app_language_switch.dart';
export 'widgets/app_labeled_field.dart';
export 'widgets/app_loading.dart';
export 'widgets/app_map_profile_button.dart';
export 'widgets/app_menu_tile.dart';
export 'widgets/app_primary_button.dart';
export 'widgets/app_profile_avatar.dart';
export 'widgets/app_skeleton.dart';
export 'widgets/app_soon_badge.dart';
export 'widgets/app_splash_branding.dart';
export 'widgets/app_stat_cards.dart';
export 'widgets/app_step_indicator.dart';
export 'widgets/app_surface_card.dart';
export 'widgets/app_text_form_field.dart';
export 'widgets/app_theme_mode_switch.dart';
export 'widgets/password_field.dart';

// Widgets — OTP (shared by the register and reset-password flows)
export 'widgets/otp/otp_countdown_timer.dart';
export 'widgets/otp/otp_pin_input.dart';
export 'widgets/otp/otp_resend_section.dart';
export 'widgets/otp/resend_otp_row.dart';
