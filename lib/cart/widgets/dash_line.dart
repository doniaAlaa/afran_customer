import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpacing;

  const DashedLine({
    Key? key,
    this.height = 1,
    this.color = Colors.black,
    this.dashWidth = 5,
    this.dashSpacing = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(
        color: color,
        dashWidth: dashWidth,
        dashSpacing: dashSpacing,
        height: height,
      ),
      child: SizedBox(
        height: height,
        width: double.infinity,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpacing;
  final double height;
  final Color color;

  _DashedLinePainter({
    required this.dashWidth,
    required this.dashSpacing,
    required this.color,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
