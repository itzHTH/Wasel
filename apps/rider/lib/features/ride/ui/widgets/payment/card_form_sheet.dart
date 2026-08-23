import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/widgets/payment/card_input_formatters.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_payments/presentation/providers/tokenize/tokenize_card_provider.dart';

Future<bool> showCardFormSheet(BuildContext context, WidgetRef ref) async {
  ref.read(tokenizeCardControllerProvider.notifier).reset();

  final tokenized = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: context.colors.screenBackground,
    useSafeArea: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
    ),
    builder: (context) => const _CardFormSheet(),
  );

  return tokenized ?? false;
}

class _CardFormSheet extends ConsumerStatefulWidget {
  const _CardFormSheet();

  @override
  ConsumerState<_CardFormSheet> createState() => _CardFormSheetState();
}

class _CardFormSheetState extends ConsumerState<_CardFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _cardNumber;
  late final TextEditingController _expiry;
  late final TextEditingController _cvv;

  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    _cardNumber = TextEditingController();
    _expiry = TextEditingController();
    _cvv = TextEditingController();
  }

  @override
  void dispose() {
    _cardNumber.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  String? _validateCardNumber(String? value) {
    final digits = digitsOnly(value ?? '');
    if (digits.isEmpty) return context.l10n.enterCardNumber;
    if (digits.length != cardNumberDigits) return context.l10n.cardNumberLength;
    return null;
  }

  String? _validateExpiry(String? value) {
    final digits = digitsOnly(value ?? '');
    if (digits.isEmpty) return context.l10n.enterExpiryDate;
    if (digits.length != expiryDigits) return context.l10n.expiryFormat;

    final month = int.parse(digits.substring(0, 2));
    if (month < 1 || month > 12) return context.l10n.invalidMonth;

    final now = DateTime.now();
    final expiry = DateTime(2000 + int.parse(digits.substring(2)), month + 1);
    if (!expiry.isAfter(DateTime(now.year, now.month))) {
      return context.l10n.cardExpired;
    }

    return null;
  }

  String? _validateCvv(String? value) {
    final digits = digitsOnly(value ?? '');
    if (digits.isEmpty) return context.l10n.enterCvv;
    if (digits.length < 3 || digits.length > 4) return context.l10n.cvvLength;
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() => _showErrors = true);

    if (!(_formKey.currentState?.validate() ?? false)) return;

    final expiry = digitsOnly(_expiry.text);

    await ref
        .read(tokenizeCardControllerProvider.notifier)
        .tokenize(
          cardNumber: digitsOnly(_cardNumber.text),
          expiryMonth: expiry.substring(0, 2),
          expiryYear: expiryYearToWire(expiry.substring(2)),
          cvv: digitsOnly(_cvv.text),
        );

    if (!mounted) return;

    // AsyncError keeps the previous value, so hasValue alone would still be
    // true after a decline and close the sheet over the error.
    final result = ref.read(tokenizeCardControllerProvider);
    if (result.hasError || result.value == null) return;

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tokenizeCardControllerProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            AppDimens.space16,
            AppDimens.space12,
            AppDimens.space16,
            AppDimens.space24,
          ),
          child: AutofillGroup(
            child: Form(
              key: _formKey,
              autovalidateMode: _showErrors
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: AppDimens.space40,
                      height: AppDimens.space4,
                      decoration: BoxDecoration(
                        color: context.colors.neutral200,
                        borderRadius: BorderRadius.circular(
                          AppDimens.radiusPill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimens.space24),
                  Text(
                    context.l10n.cardDetails,
                    textAlign: TextAlign.center,
                    style: context.styles.font16Secondary900Bold,
                  ),
                  SizedBox(height: AppDimens.space16),
                  AppLabeledFormField(
                    label: context.l10n.cardNumber,
                    hintText: '0000 0000 0000 0000',
                    controller: _cardNumber,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.creditCardNumber],
                    inputFormatters: const [CardNumberInputFormatter()],
                    validator: _validateCardNumber,
                  ),
                  SizedBox(height: AppDimens.space12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppLabeledFormField(
                          label: context.l10n.expiryDate,
                          hintText: 'MM/YY',
                          controller: _expiry,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [
                            AutofillHints.creditCardExpirationDate,
                          ],
                          inputFormatters: const [ExpiryInputFormatter()],
                          validator: _validateExpiry,
                        ),
                      ),
                      SizedBox(width: AppDimens.space8),
                      Expanded(
                        child: AppLabeledFormField(
                          label: 'CVV',
                          hintText: '123',
                          controller: _cvv,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [
                            AutofillHints.creditCardSecurityCode,
                          ],
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          validator: _validateCvv,
                        ),
                      ),
                    ],
                  ),
                  if (state.hasError) ...[
                    SizedBox(height: AppDimens.space12),
                    AppInlineError(message: state.error.toString()),
                  ],
                  SizedBox(height: AppDimens.space24),
                  AppPrimaryButton(
                    label: context.l10n.saveCard,
                    isLoading: state.isLoading,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
