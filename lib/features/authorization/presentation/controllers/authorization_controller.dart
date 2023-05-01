import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../core/enum/authorization_states.dart';
import '../../data/models/user_model.dart';

part 'authorization_controller.g.dart';

class AuthorizationController = _AuthorizationController with _$AuthorizationController;

abstract class _AuthorizationController with Store {
  static const usersBoxName = 'Users';
  static const currentUserBoxName = 'CurrentUser';
  UserModel? currentUser;
  bool reactionSetUp = false;

  @observable
  AuthorizationStates state = AuthorizationStates.initial;

  @action
  Future<void> signIn({required String name, required String password}) async {
    state = AuthorizationStates.loading;
    final boxUsers = await _getUsersBox();
    for (final user in boxUsers.values) {
      if (user.name == name && user.password == password) {
        final currentUserBox = await _getCurrentUser();
        currentUserBox.add(user);
        state = AuthorizationStates.success;
        currentUser = user;
        return;
      }
    }
    state = AuthorizationStates.signInError;
    await Future.delayed(const Duration(seconds: 1));
    state = AuthorizationStates.initial;
  }

  @action
  Future<void> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    final boxUsers = await _getUsersBox();
    if (email.isNotEmpty && name.isNotEmpty && password.isNotEmpty && _validUser(name, boxUsers)) {
      state = AuthorizationStates.loading;
      final newUser = UserModel(email: email, password: password, name: name);
      boxUsers.add(newUser);
      state = AuthorizationStates.userCreated;
      await Future.delayed(const Duration(seconds: 1));
      state = AuthorizationStates.initial;
      return;
    }
    state = AuthorizationStates.signUpError;
    await Future.delayed(const Duration(seconds: 1));
    state = AuthorizationStates.initial;
  }

  @action
  Future<void> signOut() async {
    currentUser = null;
    final currentUserBox = await _getCurrentUser();
    await currentUserBox.clear();
  }

  @action
  Future<void> initialSignIn() async {
    state = AuthorizationStates.loading;
    final currentUserBox = await _getCurrentUser();
    final boxUsers = await _getUsersBox();
    if (currentUserBox.isNotEmpty) {
      for (final user in boxUsers.values) {
        if (user.name == currentUserBox.values.first.name && user.password == currentUserBox.values.first.password) {
          state = AuthorizationStates.success;
          currentUser = user;
          return;
        }
      }
    }
  }

  bool _validUser(String name, Box<UserModel> boxUsers) {
    for (final user in boxUsers.values) {
      if (user.name == name) {
        return false;
      }
    }
    return true;
  }

  Future<Box<UserModel>> _getUsersBox() async => await Hive.openBox<UserModel>(usersBoxName);

  Future<Box<UserModel>> _getCurrentUser() async => await Hive.openBox<UserModel>(currentUserBoxName);
}
