import 'package:flutter/material.dart';

import '../../core/app_textstyles.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key, required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) => Text(
        '\$${balance.toStringAsFixed(2)}',
        style: AppTextStyles.balance,
        textAlign: .center,
      );
}
