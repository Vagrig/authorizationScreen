import 'package:flutter/material.dart';
import '../../utils/icons/app_icons.dart';
import '../../utils/titles/titles.dart';
import '../widgets/tab_bar_view_authorization.dart';
import '../widgets/wave_painter.dart';

class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 258),
                  painter: WavePainter(context),
                ),
                Positioned(left: 24, top: 54, child: Image.asset(AppIcons.logo)),
              ],
            ),
            const SizedBox(height: 92),
            const TabBarViewAuthorization(),
            const SizedBox(height: 52),
            Text(
              AppTitles.forgotPassword,
              style: TextStyle(color: Theme.of(context).cardColor),
            )
          ],
        ),
      ),
    );
  }
}
