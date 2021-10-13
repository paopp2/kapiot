import 'package:flutter/material.dart';

extension TecExtensions on TextEditingController {
  /// Select (highlight) all of this TextEditingController's text
  void selectText() {
    selection = TextSelection(
      baseOffset: 0,
      extentOffset: text.length,
    );
  }
}

extension GenericStringExtensions on String {
  /// Returns the first name (eg. John Doe -> John)
  String get firstName => split(' ').first;

  /// Returns the last name (eg. John Doe -> Doe)
  String get lastName => split(' ').last;

  /// Capitalize this String (eg. hello -> Hello)
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';

  /// Splits this String address into two: the first being the more 'specific',
  /// the other one the more 'general' (eg. ['USC-TC', 'Talamban Cebu'])
  List<String> splitAddress() {
    final index = indexOf(",");
    if (index != -1) {
      return [substring(0, index).trim(), substring(index + 1).trim()];
    } else {
      return [this, "Philippines"];
    }
  }
}
