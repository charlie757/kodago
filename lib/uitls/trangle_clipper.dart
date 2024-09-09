import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final bool isMe;
  TrianglePainter(this.isMe);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = isMe ? Colors.green[200]! : Colors.grey[200]!
      ..style = PaintingStyle.fill;

    var path = Path();
    if (isMe) {
      path.moveTo(0, 0);
      path.lineTo(-10, 10);
      path.lineTo(0, 20);
      path.close();
    } else {
      path.moveTo(0, 0);
      path.lineTo(10, 10);
      path.lineTo(0, 20);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
