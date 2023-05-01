// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthorizationController on _AuthorizationController, Store {
  late final _$stateAtom =
      Atom(name: '_AuthorizationController.state', context: context);

  @override
  AuthorizationStates get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AuthorizationStates value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$signInAsyncAction =
      AsyncAction('_AuthorizationController.signIn', context: context);

  @override
  Future<void> signIn({required String name, required String password}) {
    return _$signInAsyncAction
        .run(() => super.signIn(name: name, password: password));
  }

  late final _$signUpAsyncAction =
      AsyncAction('_AuthorizationController.signUp', context: context);

  @override
  Future<void> signUp(
      {required String email, required String name, required String password}) {
    return _$signUpAsyncAction
        .run(() => super.signUp(email: email, name: name, password: password));
  }

  late final _$signOutAsyncAction =
      AsyncAction('_AuthorizationController.signOut', context: context);

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  late final _$initialSignInAsyncAction =
      AsyncAction('_AuthorizationController.initialSignIn', context: context);

  @override
  Future<void> initialSignIn() {
    return _$initialSignInAsyncAction.run(() => super.initialSignIn());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
