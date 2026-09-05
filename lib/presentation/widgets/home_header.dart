import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_icons.dart';
import '../../core/app_textstyles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.name,
    required this.greeting,
    this.onMenuTap,
  });

  final String name;
  final String greeting;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 2,
            children: [
              Text(name, style: AppTextStyles.userName),
              Text(greeting, style: AppTextStyles.greeting),
            ],
          ),
          GestureDetector(
            onTap: onMenuTap,
            child: SvgPicture.asset(AppIcons.icDrawer, width: 28, height: 28),
          ),
        ],
      );
}
