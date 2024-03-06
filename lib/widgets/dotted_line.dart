import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double height;
  final Color color;

  const DottedLine(
      {super.key, required this.height, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(height, 1),
      painter: DashedLinePainter(),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
