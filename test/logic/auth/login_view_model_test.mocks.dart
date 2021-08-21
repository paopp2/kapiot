// Mocks generated by Mockito 5.0.14 from annotations
// in kapiot/test/logic/auth/login_view_model_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:firebase_auth/firebase_auth.dart' as _i8;
import 'package:flutter/material.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i3;
import 'package:hooks_riverpod/hooks_riverpod.dart' as _i7;
import 'package:kapiot/app_router.dart' as _i4;
import 'package:kapiot/data/services/auth_service.dart' as _i6;
import 'package:mockito/mockito.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeGlobalKey_0<T extends _i1.State<_i1.StatefulWidget>> extends _i2.Fake
    implements _i1.GlobalKey<T> {}

class _FakeGoogleSignIn_1 extends _i2.Fake implements _i3.GoogleSignIn {}

/// A class which mocks [AppRouter].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppRouter extends _i2.Mock implements _i4.AppRouter {
  MockAppRouter() {
    _i2.throwOnMissingStub(this);
  }

  @override
  _i1.GlobalKey<_i1.NavigatorState> get navigationKey =>
      (super.noSuchMethod(Invocation.getter(#navigationKey),
              returnValue: _FakeGlobalKey_0<_i1.NavigatorState>())
          as _i1.GlobalKey<_i1.NavigatorState>);
  @override
  Map<String, _i1.Widget Function(_i1.BuildContext)> get routesList =>
      (super.noSuchMethod(Invocation.getter(#routesList),
              returnValue: <String, _i1.Widget Function(_i1.BuildContext)>{})
          as Map<String, _i1.Widget Function(_i1.BuildContext)>);
  @override
  _i5.Future<dynamic>? navigateTo(String? route) =>
      (super.noSuchMethod(Invocation.method(#navigateTo, [route]))
          as _i5.Future<dynamic>?);
  @override
  void popView() => super.noSuchMethod(Invocation.method(#popView, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i2.Mock implements _i6.AuthService {
  MockAuthService() {
    _i2.throwOnMissingStub(this);
  }

  @override
  _i7.Reader get read => (super.noSuchMethod(Invocation.getter(#read),
      returnValue: <T>(_i7.ProviderBase<T> provider) => null) as _i7.Reader);
  @override
  _i3.GoogleSignIn get googleSignIn =>
      (super.noSuchMethod(Invocation.getter(#googleSignIn),
          returnValue: _FakeGoogleSignIn_1()) as _i3.GoogleSignIn);
  @override
  _i5.Future<_i8.UserCredential?> signInWithGoogle() =>
      (super.noSuchMethod(Invocation.method(#signInWithGoogle, []),
              returnValue: Future<_i8.UserCredential?>.value())
          as _i5.Future<_i8.UserCredential?>);
  @override
  _i5.Future<void> signOutGoogle() =>
      (super.noSuchMethod(Invocation.method(#signOutGoogle, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<_i8.AuthCredential?> googleCredentials() =>
      (super.noSuchMethod(Invocation.method(#googleCredentials, []),
              returnValue: Future<_i8.AuthCredential?>.value())
          as _i5.Future<_i8.AuthCredential?>);
  @override
  String toString() => super.toString();
}
