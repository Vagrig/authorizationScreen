import 'package:authorization/features/authorization/presentation/screens/authorization_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors/app_colors.dart';
import '../controllers/authorization_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthorizationController(),
      child: MaterialApp(
        darkTheme: ThemeData(
            backgroundColor: AppColors.darkBackground,
            secondaryHeaderColor: AppColors.darkSecondary,
            hintColor: AppColors.darkForeground,
            primaryColor: AppColors.darkPrimary,
            cardColor: AppColors.permanentWhite),
        theme: ThemeData(
            backgroundColor: AppColors.lightBackground,
            secondaryHeaderColor: AppColors.lightSecondary,
            hintColor: AppColors.lightForeground,
            primaryColor: AppColors.lightPrimary,
            cardColor: AppColors.permanentBlue),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const AuthorizationScreen(),
      ),
    );
  }
}
