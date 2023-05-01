import 'package:authorization/features/authorization/presentation/widgets/snack_bar_authorization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../core/enum/authorization_states.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/titles/titles.dart';
import '../controllers/authorization_controller.dart';
import 'package:provider/provider.dart';

import '../screens/user_screen.dart';

class TabBarViewAuthorization extends StatefulWidget {
  const TabBarViewAuthorization({Key? key}) : super(key: key);

  @override
  State<TabBarViewAuthorization> createState() => _TabBarViewAuthorizationState();
}

class _TabBarViewAuthorizationState extends State<TabBarViewAuthorization> with TickerProviderStateMixin {
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TabController _tabBarController;
  late ReactionDisposer _reactionDisposer;

  @override
  void initState() {
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _tabBarController = TabController(length: 2, vsync: this);
    context.read<AuthorizationController>().initialSignIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 162,
          child: TabBarView(
            controller: _tabBarController,
            children: [
              _buildLoginTextField(),
              _buildSignUpTextField(),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildTabBar(context),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor, borderRadius: const BorderRadius.all(Radius.circular(20))),
        width: double.maxFinite,
        height: 40,
        child: TabBar(
          labelColor: AppColors.permanentWhite,
          unselectedLabelColor: Theme.of(context).hintColor,
          onTap: _onTap,
          overlayColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
          indicator:
              const BoxDecoration(color: AppColors.permanentBlue, borderRadius: BorderRadius.all(Radius.circular(20))),
          controller: _tabBarController,
          tabs: const [
            Tab(child: Text(AppTitles.login)),
            Tab(child: Text(AppTitles.signUp)),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginTextField() {
    return Column(
      children: [
        const SizedBox(height: 58),
        _buildTextField(AppTitles.username, _usernameController),
        const SizedBox(height: 12),
        _buildTextField(AppTitles.password, _passwordController, true),
      ],
    );
  }

  Widget _buildSignUpTextField() {
    return Column(
      children: [
        _buildTextField(AppTitles.email, _emailController),
        const SizedBox(height: 12),
        _buildTextField(AppTitles.username, _usernameController),
        const SizedBox(height: 12),
        _buildTextField(AppTitles.password, _passwordController),
      ],
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller, [bool obscure = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        height: 46,
        child: TextField(
          obscureText: obscure,
          controller: controller,
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(color: Theme.of(context).hintColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 16, right: 32, bottom: 12, top: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    if (_tabBarController.index == 0 && !_tabBarController.indexIsChanging) {
      context
          .read<AuthorizationController>()
          .signIn(name: _usernameController.text, password: _passwordController.text);
    } else if (_tabBarController.index == 1 && !_tabBarController.indexIsChanging) {
      context.read<AuthorizationController>().signUp(
            email: _emailController.text,
            name: _usernameController.text,
            password: _passwordController.text,
          );
    }
    if (_tabBarController.previousIndex == 0 && _tabBarController.index == 1 && _tabBarController.indexIsChanging) {
      _emailController.clear();
      _passwordController.clear();
      _usernameController.clear();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<AuthorizationController>();
    if (!state.reactionSetUp) {
      state.reactionSetUp = true;
      _reactionDisposer = reaction((_) => state.state == AuthorizationStates.success, (bool loggedIn) {
        if (loggedIn && state.currentUser != null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => UserScreen(user: state.currentUser!)));
        }
      });
      _reactionDisposer = reaction((_) => state.state == AuthorizationStates.signInError, (bool isError) {
        if (isError) {
          Future.delayed(Duration.zero).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 1200),
                backgroundColor: Theme.of(context).backgroundColor,
                content: const SnackBarAuthorization(
                  title: AppTitles.error,
                  subtitle: AppTitles.loginErrorSubtitle,
                  leading: Icons.cancel,
                  color: AppColors.permanentRed,
                ),
              )));
        }
      });
      _reactionDisposer = reaction((_) => state.state == AuthorizationStates.signUpError, (bool isError) {
        if (isError) {
          Future.delayed(Duration.zero).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 1200),
                backgroundColor: Theme.of(context).backgroundColor,
                content: const SnackBarAuthorization(
                  title: AppTitles.error,
                  subtitle: AppTitles.signUpErrorSubtitle,
                  leading: Icons.cancel,
                  color: AppColors.permanentRed,
                ),
              )));
        }
      });
      _reactionDisposer = reaction((_) => state.state == AuthorizationStates.userCreated, (bool userCreated) {
        if (userCreated) {
          Future.delayed(Duration.zero).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 1200),
                backgroundColor: Theme.of(context).backgroundColor,
                content: const SnackBarAuthorization(
                  title: AppTitles.wellDone,
                  subtitle: AppTitles.successfulSubtitle,
                  leading: Icons.check_circle_rounded,
                  color: AppColors.permanentGreen,
                ),
              )));
        }
      });
    }
  }

  @override
  void dispose() {
    _reactionDisposer();
    super.dispose();
  }
}
