import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_data.dart';
import '../widgets/balance_section.dart';
import '../widgets/expense_line_chart.dart';
import '../widgets/home_header.dart';
import '../widgets/month_selector.dart';
import '../widgets/transaction_tile.dart';

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
                  HomeHeader(name: AppData.userName, greeting: AppData.greeting),
                  Column(
                    spacing: 16,
                    children: [
                      BalanceSection(balance: AppData.balance),
                      ExpenseLineChart(points: AppData.chartPoints),
                    ],
                  ),
                  MonthSelector(
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
                itemBuilder: (context, index) => TransactionTile(transaction: AppData.transactions[index]),
              ),
            ),
          ],
        ),
      );
}
