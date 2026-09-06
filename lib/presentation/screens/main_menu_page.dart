import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_colors.dart';
import '../../core/app_icons.dart';
import '../dialogs/add_transaction_dialog.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  int get _bottomNavIndex => navigationShell.currentIndex >= 2 ? navigationShell.currentIndex + 1 : navigationShell.currentIndex;

  void _onNavTap(BuildContext context, int index) {
    if (index == 2) {
      showDialog(context: context, builder: (_) => const AddTransactionDialog());
      return;
    }
    navigationShell.goBranch(index > 2 ? index - 1 : index);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(child: navigationShell),
        bottomNavigationBar: BottomNavigationBar(
          type: .fixed,
          backgroundColor: AppColors.whiteColor,
          selectedItemColor: AppColors.blackColor,
          unselectedItemColor: AppColors.blackColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _bottomNavIndex,
          onTap: (index) => _onNavTap(context, index),
          items: [
            _buildBottomNavigationBarItemWidget(icon: AppIcons.icExpenseInvoice),
            _buildBottomNavigationBarItemWidget(icon: AppIcons.icWallet),
            _buildBottomNavigationBarItemWidget(icon: AppIcons.icAdd, isAdd: true),
            _buildBottomNavigationBarItemWidget(icon: AppIcons.icChartUp),
            _buildBottomNavigationBarItemWidget(icon: AppIcons.icSettings),
          ],
        ),
      );

  BottomNavigationBarItem _buildBottomNavigationBarItemWidget({required String icon, bool isAdd = false}) => BottomNavigationBarItem(
        icon: isAdd
            ? Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: .circle,
                  color: AppColors.blackColor,
                ),
                alignment: .center,
                child: SvgPicture.asset(icon, width: 20, height: 20, colorFilter: .mode(AppColors.whiteColor, .srcIn)),
              )
            : SvgPicture.asset(icon, width: 24, height: 24, colorFilter: .mode(AppColors.blackColor, .srcIn)),
        label: '',
      );
}
