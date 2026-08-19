import 'package:flutter/services.dart';

const int cardNumberDigits = 16;
const int expiryDigits = 4;

String digitsOnly(String value) => value.replaceAll(RegExp(r'\D'), '');

/// The card shows YY and the gateway rejects anything but YYYY.
String expiryYearToWire(String twoDigitYear) => '20$twoDigitYear';

TextEditingValue _collapsedAtEnd(String text) => TextEditingValue(
  text: text,
  selection: TextSelection.collapsed(offset: text.length),
);

class CardNumberInputFormatter extends TextInputFormatter {
  const CardNumberInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = digitsOnly(newValue.text);
    final capped = digits.length > cardNumberDigits
        ? digits.substring(0, cardNumberDigits)
        : digits;

    final grouped = StringBuffer();
    for (var i = 0; i < capped.length; i++) {
      if (i > 0 && i % 4 == 0) grouped.write(' ');
      grouped.write(capped[i]);
    }

    return _collapsedAtEnd(grouped.toString());
  }
}

class ExpiryInputFormatter extends TextInputFormatter {
  const ExpiryInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = digitsOnly(newValue.text);
    final capped = digits.length > expiryDigits
        ? digits.substring(0, expiryDigits)
        : digits;

    if (capped.length <= 2) return _collapsedAtEnd(capped);

    return _collapsedAtEnd('${capped.substring(0, 2)}/${capped.substring(2)}');
  }
}
