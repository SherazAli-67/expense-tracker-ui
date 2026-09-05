import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class ExpenseLineChart extends StatelessWidget {
  const ExpenseLineChart({
    super.key,
    required this.points,
    this.height = 125,
  });

  final List<double> points;
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: .infinity,
        height: height,
        child: CustomPaint(painter: _ExpenseLineChartPainter(points: points)),
      );
}

class _ExpenseLineChartPainter extends CustomPainter {
  _ExpenseLineChartPainter({required this.points});

  final List<double> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final minY = points.reduce((a, b) => a < b ? a : b);
    final maxY = points.reduce((a, b) => a > b ? a : b);
    final rangeY = (maxY - minY).clamp(1.0, double.infinity);
    final dx = size.width / (points.length - 1);
    final markerRadius = 10.0;
    final chartHeight = size.height - markerRadius * 2;

    Offset pointFor(int i) {
      final x = dx * i;
      final normalized = (points[i] - minY) / rangeY;
      final y = size.height - markerRadius - (normalized * chartHeight);
      return Offset(x, y);
    }

    final path = Path()..moveTo(pointFor(0).dx, pointFor(0).dy);
    for (var i = 0; i < points.length - 1; i++) {
      final current = pointFor(i);
      final next = pointFor(i + 1);
      final controlX = (current.dx + next.dx) / 2;
      path.cubicTo(controlX, current.dy, controlX, next.dy, next.dx, next.dy);
    }

    final linePaint = Paint()
      ..color = AppColors.blackColor
      ..style = .stroke
      ..strokeWidth = 2
      ..strokeCap = .round
      ..strokeJoin = .round;

    canvas.drawPath(path, linePaint);

    final markerIndex = points.indexOf(maxY);
    final markerCenter = pointFor(markerIndex);
    canvas.drawCircle(
      markerCenter,
      markerRadius,
      Paint()
        ..color = AppColors.whiteColor
        ..style = .fill,
    );
    canvas.drawCircle(
      markerCenter,
      markerRadius,
      Paint()
        ..color = AppColors.blackColor
        ..style = .stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _ExpenseLineChartPainter oldDelegate) => oldDelegate.points != points;
}
