import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/string_const.dart';
import '../../core/app_colors.dart';
import '../../core/app_data.dart';
import '../../core/app_icons.dart';
import '../../core/app_textstyles.dart';
import '../../core/models/day_chip_model.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  int _selectedDayIndex = AppData.selectedDayChipIndex;
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: AppColors.whiteColor,
        insetPadding: .symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: .circular(24)),
        child: Padding(
          padding: .all(24),
          child: Column(
            mainAxisSize: .min,
            spacing: 48,
            children: [
              Column(
                spacing: 24,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(StringConst.addTransaction, style: AppTextStyles.modalTitle),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(AppIcons.icCancel, width: 24, height: 24),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 55,
                    child: ListView.separated(
                      scrollDirection: .horizontal,
                      itemCount: AppData.dayChips.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 14),
                      itemBuilder: (context, index) => _DayChip(
                        day: AppData.dayChips[index],
                        isSelected: index == _selectedDayIndex,
                        onTap: () => setState(() => _selectedDayIndex = index),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 24,
                children: [
                  Text(
                    '\$${AppData.balance.toStringAsFixed(2)}',
                    style: AppTextStyles.balance,
                    textAlign: .center,
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.neutral200Color,
                          shape: .circle,
                        ),
                        alignment: .center,
                        child: SvgPicture.asset(AppIcons.icTransactionEmoji, width: 24, height: 24),
                      ),
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: .symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: AppColors.neutral200Color,
                            borderRadius: .circular(22),
                          ),
                          alignment: .centerLeft,
                          child: TextField(
                            controller: _reasonController,
                            style: AppTextStyles.transactionAmount,
                            decoration: InputDecoration(
                              isDense: true,
                              border: .none,
                              hintText: StringConst.enterYourReason,
                              hintStyle: AppTextStyles.reasonHint,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  final DayChipModel day;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 35,
          height: 60,
          // padding: .all(10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.blackColor : AppColors.neutral200Color,
            borderRadius: .circular(18),
          ),
          child: Column(
            mainAxisAlignment: .center,
            spacing: 2,
            children: [
              Text(
                day.weekdayLetter,
                style: isSelected ? AppTextStyles.dayChipLabelSelected : AppTextStyles.dayChipLabel,
              ),
              FittedBox(
                child: Text(
                  day.dayNumber,
                  style: isSelected ? AppTextStyles.dayChipNumberSelected : AppTextStyles.dayChipNumber,
                ),
              ),
            ],
          ),
        ),
      );
}
