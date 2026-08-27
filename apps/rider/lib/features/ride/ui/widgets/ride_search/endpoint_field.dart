import 'package:flutter/widgets.dart';
import 'package:wasel_location/wasel_location.dart';

/// The text controller and focus node behind one endpoint of the search
/// header, kept together because nothing ever needs one without the other.
class EndpointField {
  EndpointField(this.type);

  final SearchFieldType type;
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool get isPickup => type.isPickup;

  String get query => controller.text.trim();

  bool get isBlank => query.isEmpty;

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }
}
