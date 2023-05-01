import 'package:authorization/features/authorization/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class SnackBarAuthorization extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final IconData _leading;
  final Color _color;
  const SnackBarAuthorization({
    super.key,
    required String title,
    required String subtitle,
    required IconData leading,
    required Color color,
  })  : _title = title,
        _subtitle = subtitle,
        _leading = leading,
        _color = color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: _color, borderRadius: const BorderRadius.all(Radius.circular(12))),
      width: MediaQuery.of(context).size.width,
      height: 94,
      child: Center(
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_leading, size: 30, color: AppColors.permanentWhite),
            ],
          ),
          title: Text(_title, style: const TextStyle(fontSize: 22, color: AppColors.permanentWhite)),
          subtitle: Text(_subtitle, style: const TextStyle(fontSize: 16, color: AppColors.permanentWhite)),
          trailing: IconButton(
            icon: const Icon(Icons.close_sharp, size: 20, color: AppColors.permanentWhite),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      ),
    );
  }
}
