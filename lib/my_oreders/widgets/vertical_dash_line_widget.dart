import 'package:flutter/material.dart';

class VerticalDashLineWidegt extends StatelessWidget {
  final double height;
  final Color color;

  const VerticalDashLineWidegt({
    this.height = 100,
    this.color = Colors.grey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(1, height),
      painter: _VerticalDashedLinePainter(color: color),
    );
  }
}

class _VerticalDashedLinePainter extends CustomPainter {
  final Color color;

  _VerticalDashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const dashHeight = 3.0;
    const dashSpace = 2.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
