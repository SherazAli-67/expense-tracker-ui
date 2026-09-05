import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_textstyles.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({
    super.key,
    required this.months,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> months;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
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
                padding: .symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blackColor : AppColors.neutral200Color,
                  borderRadius: .circular(999),
                ),
                alignment: .center,
                child: Text(
                  months[index],
                  style: isSelected ? AppTextStyles.monthChipSelected : AppTextStyles.monthChip,
                ),
              ),
            );
          },
        ),
      );
}
