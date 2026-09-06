import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_textstyles.dart';
import '../../core/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) => Column(
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
                  decoration: BoxDecoration(
                    color: AppColors.neutral200Color,
                    shape: .circle,
                  ),
                  alignment: .center,
                  child: Text(transaction.emoji, style: const TextStyle(fontSize: 32, height: 1.1)),
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
                            Text(transaction.dateLabel, style: AppTextStyles.transactionDate),
                            Text(transaction.title, style: AppTextStyles.transactionTitle),
                          ],
                        ),
                      ),
                      Text(
                        '${transaction.isIncome ? '' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                        style: AppTextStyles.transactionAmount,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColors.dividerColor.withValues(alpha: 0.2),
            width: .infinity,
          )
          // const Divider(height: 1, thickness: 1, color: AppColors.dividerColor),
        ],
      );
}
