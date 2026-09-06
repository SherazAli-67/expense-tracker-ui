import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/app_colors.dart';
import '../../core/app_data.dart';
import '../../core/app_icons.dart';
import '../../core/app_textstyles.dart';
import '../../core/models/transaction_model.dart';

class ExpenseTrackingScreen extends StatefulWidget {
  const ExpenseTrackingScreen({super.key});

  @override
  State<ExpenseTrackingScreen> createState() => _ExpenseTrackingScreenState();
}

class _ExpenseTrackingScreenState extends State<ExpenseTrackingScreen> {
  int _selectedMonthIndex = AppData.selectedMonthIndex;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: [
            Padding(
              padding: .symmetric(horizontal: 20, vertical: 20),
              child: Column(
                spacing: 28,
                children: [
                  _buildHeaderWidget(name: AppData.userName, greeting: AppData.greeting),
                  Column(
                    spacing: 16,
                    children: [
                      //\$${balance.toStringAsFixed(2)}, balance, alignment: center
                      // _buildExpenseLineChartWidget(points: AppData.chartPoints),
                    ],
                  ),
                  _buildMonthSelectorWidget(
                    months: AppData.months,
                    selectedIndex: _selectedMonthIndex,
                    onSelected: (index) => setState(() => _selectedMonthIndex = index),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: .symmetric(horizontal: 10),
                itemCount: AppData.transactions.length,
                itemBuilder: (context, index) => _buildTransactionTileWidget(transaction: AppData.transactions[index]),
              ),
            ),
          ],
        ),
      );

  Widget _buildHeaderWidget({required String name, required String greeting, VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .start,
      children: [
        Column(
          crossAxisAlignment: .start,
          spacing: 2,
          children: [
            //name, userName
            //greeting, greeting
          ],
        ),

        //icDrawer, height;28
        GestureDetector(
          onTap: onTap,
          child: const SizedBox()
        ),
      ],
    );
  }

  Widget _buildExpenseLineChartWidget({required List<double> points, double height = 125}) {
    return SizedBox(
      width: .infinity,
      height: height,
      child: CustomPaint(painter: _ExpenseLineChartPainter(points: points)),
    );
  }

  Widget _buildMonthSelectorWidget({
    required List<String> months,
    required int selectedIndex,
    required ValueChanged<int> onSelected,
  }) {
    return SizedBox(
      height: 23,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: months.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              // padding: .symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                // color: isSelected ? AppColors.blackColor : AppColors.neutral200Color,
                // borderRadius: .circular(99),
              ),
              // alignment: .center,

              //months[index], isSelected ? AppTextStyles.monthChipSelected : AppTextStyles.monthChip
              child: const SizedBox()
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionTileWidget({required TransactionModel transaction}) {
    return Column(
      spacing: 16,
      children: [
        Padding(
          padding: .zero,
          child: Row(
            spacing: 16,
            crossAxisAlignment: .center,
            children: [
              Container(
                width: 56,
                height: 56,
                // margin: .only(top: 10),
                // decoration: BoxDecoration(color: AppColors.neutral200Color, shape: .circle),
                // alignment: .center,

                //transaction.emoji, style: 32, height:1.1
                child: const SizedBox()
              ),
              Expanded(
                child: Row(
                  spacing: 15,
                  crossAxisAlignment: .center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: 2,
                        children: [

                          //transaction.dateLabel, transactionDate
                          //transaction.title, transactionTitle
                        ],
                      ),
                    ),

                    //${transaction.isIncome ? '' : '-'}\$${transaction.amount.toStringAsFixed(2)}, transactionAmount
                    Text(
                      '',
                      style: AppTextStyles.transactionAmount,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Container(height: 1, color: AppColors.dividerColor.withValues(alpha: 0.2), width: .infinity),
      ],
    );
  }
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
