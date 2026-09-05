import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_colors.dart';
import '../../core/app_icons.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: .centerDocked,

        bottomNavigationBar: BottomNavigationBar(
            type: .fixed,
            backgroundColor: AppColors.whiteColor,
            onTap: (index)=> navigationShell.goBranch(index),
            selectedItemColor: AppColors.blackColor,
            currentIndex: navigationShell.currentIndex,
            items: [
              _buildBottomNavigationBarItemWidget(icon:  AppIcons.icExpenseInvoice, label: '', index: 0),
              _buildBottomNavigationBarItemWidget(icon: AppIcons.icWallet, label: '', index: 1),
              _buildBottomNavigationBarItemWidget(icon: AppIcons.icAdd, label: '', index: -1, isAdd: true),
              _buildBottomNavigationBarItemWidget(icon: AppIcons.icChartUp, label: '', index: 2),
              _buildBottomNavigationBarItemWidget(icon: AppIcons.icSettings, label: '', index: 3),
            ]),
        body: SafeArea(child: navigationShell)
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItemWidget({required String icon, required String label, required int index, bool isAdd = false}) =>
      BottomNavigationBarItem(
        icon: isAdd ? Container(decoration: BoxDecoration(
          shape: .circle,
          color: AppColors.blackColor
        ),
          height: 36,
          alignment: .center,
          child: SvgPicture.asset(icon),
        ) : SvgPicture.asset(icon), label: label,
      );

}