import 'package:authorization/features/authorization/utils/colors/app_colors.dart';
import 'package:authorization/features/authorization/utils/titles/titles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/user_model.dart';
import '../controllers/authorization_controller.dart';

class UserScreen extends StatelessWidget {
  final UserModel user;
  const UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).hintColor;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.person, color: color),
            const SizedBox(width: 15),
            Text(user.name, style: TextStyle(color: color, fontSize: 18)),
            const SizedBox(width: 15),
            Text(user.email, style: TextStyle(color: color, fontSize: 18)),
          ]),
          const SizedBox(height: 20),
          _buildElevatedButton(context)
        ],
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
            (Set<MaterialState> states) => const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          ),
          backgroundColor: MaterialStateProperty.all(AppColors.permanentBlue),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          )),
      onPressed: () async {
        Navigator.of(context).pop();
        await context.read<AuthorizationController>().signOut();
      },
      child: const Text(
        AppTitles.signOut,
        style: TextStyle(color: AppColors.permanentWhite, fontSize: 18),
      ),
    );
  }
}
