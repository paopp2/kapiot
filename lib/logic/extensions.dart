import 'package:flutter/material.dart';

extension TecExtensionMethods on TextEditingController {
  void selectText() {
    selection = TextSelection(
      baseOffset: 0,
      extentOffset: text.length,
    );
  }
}
