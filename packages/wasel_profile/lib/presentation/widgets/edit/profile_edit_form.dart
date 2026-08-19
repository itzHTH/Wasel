import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_dialog.dart';
import 'package:wasel_profile/domain/entities/profile_edit_capabilities.dart';
import 'package:wasel_profile/core/validators/profile_edit_validators.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_field.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_save_button.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_values.dart';

/// The editable half of the profile screen.
class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({
    super.key,
    required this.capabilities,
    required this.initialFirstName,
    required this.initialLastName,
    required this.initialPhoneNumber,
    required this.isSaving,
    required this.onSave,
  });

  final ProfileEditCapabilities capabilities;
  final String initialFirstName;
  final String initialLastName;
  final String initialPhoneNumber;
  final bool isSaving;
  final void Function(ProfileEditValues values) onSave;

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneNumberController;

  var _autovalidateMode = AutovalidateMode.disabled;
  var _isDirty = false;

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController(text: widget.initialFirstName)
      ..addListener(_recomputeDirty);
    _lastNameController = TextEditingController(text: widget.initialLastName)
      ..addListener(_recomputeDirty);
    _phoneNumberController = TextEditingController(
      text: widget.initialPhoneNumber,
    )..addListener(_recomputeDirty);
  }

  @override
  void didUpdateWidget(ProfileEditForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The profile provider can emit again while this form is open (a photo
    // upload invalidates it). Re-baseline without clobbering what is typed.
    if (widget.initialFirstName != oldWidget.initialFirstName ||
        widget.initialLastName != oldWidget.initialLastName ||
        widget.initialPhoneNumber != oldWidget.initialPhoneNumber) {
      _recomputeDirty();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _recomputeDirty() {
    final isDirty =
        _firstNameController.text.trim() != widget.initialFirstName.trim() ||
        _lastNameController.text.trim() != widget.initialLastName.trim() ||
        _phoneNumberController.text.trim() != widget.initialPhoneNumber.trim();

    // Only rebuild when the flag actually flips, not on every keystroke.
    if (isDirty == _isDirty) return;
    setState(() => _isDirty = isDirty);
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
      return;
    }

    FocusScope.of(context).unfocus();

    widget.onSave(
      ProfileEditValues(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
      ),
    );
  }

  Future<void> _confirmDiscard() async {
    final discard = await AppDialog.show(
      context,
      title: 'تجاهل التعديلات؟',
      message: 'لديك تغييرات لم يتم حفظها. هل تريد الخروج وتجاهلها؟',
      confirmLabel: 'تجاهل',
      cancelLabel: 'متابعة التعديل',
      icon: Icons.edit_off_rounded,
      isDestructive: true,
    );

    if (!discard || !mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final capabilities = widget.capabilities;

    return PopScope(
      // Blocked outright while saving: if the discard dialog were open when
      // the save resolved, the pop that follows a successful save would close
      // the dialog instead of this screen.
      canPop: !_isDirty && !widget.isSaving,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop || widget.isSaving) return;
        _confirmDiscard();
      },
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileEditField(
              label: 'الاسم الأول',
              hintText: 'أدخل اسمك الأول',
              controller: _firstNameController,
              isEditable: capabilities.canEditFirstName,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  ProfileEditValidators.name(value, fieldLabel: 'الاسم الأول'),
            ),
            SizedBox(height: AppDimens.space16),
            ProfileEditField(
              label: 'اسم العائلة',
              hintText: 'أدخل اسم عائلتك',
              controller: _lastNameController,
              isEditable: capabilities.canEditLastName,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  ProfileEditValidators.name(value, fieldLabel: 'اسم العائلة'),
            ),
            SizedBox(height: AppDimens.space16),
            ProfileEditField(
              label: 'رقم الهاتف',
              hintText: '07XXXXXXXXX',
              controller: _phoneNumberController,
              isEditable: capabilities.canEditPhoneNumber,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              valueTextDirection: TextDirection.ltr,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              validator: ProfileEditValidators.phoneNumber,
            ),
            SizedBox(height: AppDimens.space32),
            ProfileEditSaveButton(
              isEnabled: _isDirty && !widget.isSaving,
              isSaving: widget.isSaving,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
