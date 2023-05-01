import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final BuildContext _context;
  WavePainter(this._context);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Theme.of(_context).secondaryHeaderColor
      ..style = PaintingStyle.fill;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.993);
    path0.lineTo(0, 0);
    path0.lineTo(size.width * 0.999, 0);
    path0.lineTo(size.width, size.height);
    path0.quadraticBezierTo(size.width * 0.975, size.height * 0.943, size.width * 0.960, size.height * 0.912);
    path0.cubicTo(size.width * 0.925, size.height * 0.849, size.width * 0.891, size.height * 0.826, size.width * 0.869,
        size.height * 0.811);
    path0.cubicTo(size.width * 0.833, size.height * 0.789, size.width * 0.758, size.height * 0.761, size.width * 0.667,
        size.height * 0.780);
    path0.quadraticBezierTo(size.width * 0.500, size.height * 0.822, 0, size.height * 0.993);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
