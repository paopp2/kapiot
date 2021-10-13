import 'package:flutter/material.dart';

extension TecExtensionMethods on TextEditingController {
  /// Select (highlight) all of this TextEditingController's text
  void selectText() {
    selection = TextSelection(
      baseOffset: 0,
      extentOffset: text.length,
    );
  }
}

extension AddressExtensionMethods on String {
  /// Splits this address into two: the first being the more 'specific',
  /// the other one the more 'general' (eg. ['USC-TC Talamban', 'Talamban Cebu'])
  List<String> splitAddress() {
    final index = indexOf(",");
    if (index != -1) {
      return [substring(0, index).trim(), substring(index + 1).trim()];
    } else {
      return [this, "Philippines"];
    }
  }
}
