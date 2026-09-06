import 'package:expense_tracker_ui/core/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_colors.dart';
import '../../core/app_data.dart';
import '../../core/app_textstyles.dart';
import '../../core/models/transaction_model.dart';

class ExpenseTrackingScreen extends StatefulWidget {
  const ExpenseTrackingScreen({super.key});

  @override
  State<ExpenseTrackingScreen> createState() => _ExpenseTrackingScreenState();
}

class _ExpenseTrackingScreenState extends State<ExpenseTrackingScreen> with SingleTickerProviderStateMixin {
  int _selectedMonthIndex = AppData.selectedMonthIndex;
  late final AnimationController _entranceController;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _balanceFade;
  late final Animation<double> _balanceValue;
  late final Animation<double> _chartProgress;
  late final Animation<double> _monthsFade;
  late final Animation<Offset> _monthsSlide;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _headerFade = CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic));
    _headerSlide = Tween(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic)));
    _balanceFade = CurvedAnimation(parent: _entranceController, curve: const Interval(0.08, 0.45, curve: Curves.easeOutCubic));
    _balanceValue = Tween(begin: 0.0, end: AppData.balance).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.08, 0.7, curve: Curves.easeOutCubic)));
    _chartProgress = CurvedAnimation(parent: _entranceController, curve: const Interval(0.15, 0.75, curve: Curves.easeOutCubic));
    _monthsFade = CurvedAnimation(parent: _entranceController, curve: const Interval(0.28, 0.55, curve: Curves.easeOutCubic));
    _monthsSlide = Tween(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.28, 0.55, curve: Curves.easeOutCubic)));
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

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
                  FadeTransition(
                    opacity: _headerFade,
                    child: SlideTransition(position: _headerSlide, child: _buildHeaderWidget(name: AppData.userName, greeting: AppData.greeting)),
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      FadeTransition(
                        opacity: _balanceFade,
                        child: AnimatedBuilder(
                          animation: _balanceValue,
                          builder: (context, _) => Text('\$${_balanceValue.value.toStringAsFixed(2)}', style: AppTextStyles.balance, textAlign: .center,),
                        ),
                      ),
                      _buildExpenseLineChartWidget(points: AppData.chartPoints),
                    ],
                  ),
                  FadeTransition(
                    opacity: _monthsFade,
                    child: SlideTransition(
                      position: _monthsSlide,
                      child: _buildMonthSelectorWidget(
                        months: AppData.months,
                        selectedIndex: _selectedMonthIndex,
                        onSelected: (index) => setState(() => _selectedMonthIndex = index),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: .symmetric(horizontal: 10),
                itemCount: AppData.transactions.length,
                itemBuilder: (context, index) => _buildAnimatedTransactionTileWidget(index: index, transaction: AppData.transactions[index]),
              ),
            ),
          ],
        ),
      );

  Widget _buildHeaderWidget({required String name, required String greeting, VoidCallback? onTap}) => Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 2,
            children: [
              Text(name, style: AppTextStyles.userName,),
              Text(greeting, style: AppTextStyles.greeting,),
            ],
          ),
          GestureDetector(onTap: onTap, child: SvgPicture.asset(AppIcons.icDrawer, height: 28,)),
        ],
      );

  Widget _buildExpenseLineChartWidget({required List<double> points, double height = 125}) => SizedBox(
        width: .infinity,
        height: height,
        child: AnimatedBuilder(
          animation: _chartProgress,
          builder: (context, _) => CustomPaint(painter: _ExpenseLineChartPainter(points: points, progress: _chartProgress.value)),
        ),
      );

  Widget _buildMonthSelectorWidget({
    required List<String> months,
    required int selectedIndex,
    required ValueChanged<int> onSelected,
  }) =>
      SizedBox(
        height: 23,
        child: ListView.separated(
          scrollDirection: .horizontal,
          itemCount: months.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () => onSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: .symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blackColor : AppColors.neutral200Color,
                  borderRadius: .circular(99),
                ),
                alignment: .center,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  style: isSelected ? AppTextStyles.monthChipSelected : AppTextStyles.monthChip,
                  child: Text(months[index]),
                ),
              ),
            );
          },
        ),
      );

  Widget _buildAnimatedTransactionTileWidget({required int index, required TransactionModel transaction}) {
    final staggerIndex = index.clamp(0, 7);
    final start = 0.35 + staggerIndex * 0.05;
    final end = (start + 0.25).clamp(0.0, 1.0);
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        final t = Curves.easeOutCubic.transform(((_entranceController.value - start) / (end - start)).clamp(0.0, 1.0));
        return Opacity(opacity: t, child: Transform.translate(offset: Offset(0, 16 * (1 - t)), child: child));
      },
      child: _buildTransactionTileWidget(transaction: transaction),
    );
  }

  Widget _buildTransactionTileWidget({required TransactionModel transaction}) => Column(
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
                  margin: .only(top: 10),
                  decoration: BoxDecoration(color: AppColors.neutral200Color),
                  alignment: .center,
                  child: Text(transaction.emoji, style: TextStyle(fontSize: 32, height: 1.1),),
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
                            Text(transaction.dateLabel, style: AppTextStyles.transactionDate,),
                            Text(transaction.title, style: AppTextStyles.transactionTitle,),
                          ],
                        ),
                      ),
                      Text('${transaction.isIncome ? '' : '-'}\$${transaction.amount.toStringAsFixed(2)}', style: AppTextStyles.transactionAmount,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: AppColors.dividerColor.withValues(alpha: 0.2), width: .infinity),
        ],
      );
}

class _ExpenseLineChartPainter extends CustomPainter {
  _ExpenseLineChartPainter({required this.points, required this.progress});

  final List<double> points;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final minY = points.reduce((a, b) => a < b ? a : b);
    final maxY = points.reduce((a, b) => a > b ? a : b);
    final rangeY = (maxY - minY).clamp(1.0, double.infinity);
    final dx = size.width / (points.length - 1);
    final markerRadius = 10.0;
    final chartHeight = size.height - markerRadius * 2;
    final clampedProgress = progress.clamp(0.0, 1.0);

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

    for (final metric in path.computeMetrics()) {
      canvas.drawPath(metric.extractPath(0, metric.length * clampedProgress), linePaint);
    }

    final markerProgress = ((clampedProgress - 0.85) / 0.15).clamp(0.0, 1.0);
    if (markerProgress <= 0) return;

    final markerIndex = points.indexOf(maxY);
    final markerCenter = pointFor(markerIndex);
    final radius = markerRadius * markerProgress;
    canvas.drawCircle(markerCenter, radius, Paint()..color = AppColors.whiteColor..style = .fill);
    canvas.drawCircle(markerCenter, radius, Paint()..color = AppColors.blackColor..style = .stroke..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant _ExpenseLineChartPainter oldDelegate) => oldDelegate.points != points || oldDelegate.progress != progress;
}
