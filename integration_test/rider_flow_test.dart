import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kapiot/main.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  final startLocTextFieldHome =
      find.widgetWithText(TextField, "Start location");
  find.widgetWithIcon(TextField, CupertinoIcons.smallcircle_circle);
  testWidgets(
    "Pressing on Start Location TextField",
    (WidgetTester tester) async {
      tester.pumpWidget(const ProviderScope(child: MyApp()));
      tester.tap(startLocTextFieldHome);
    },
  );
}
