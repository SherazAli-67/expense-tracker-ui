import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../constants/string_const.dart';
import '../../core/app_colors.dart';
import '../../core/app_icons.dart';
import '../../core/app_textstyles.dart';
import '../../router/app_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _goHome(BuildContext context) => context.go(NamedRoutes.expenseTracking.routeName);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final scale = width / 402;
            return Stack(
              children: [
                Positioned(top: 0, left: 0, right: 0, height: height * 0.69, child: _buildHeroImageWidget()),
                Positioned(
                  left: 15 * scale,
                  top: 89 * scale,
                  child: _buildFeatureTagWidget(
                    icon: AppIcons.icWallet,
                    label: StringConst.welcomeSubscriptionTag,
                    width: 202 * scale,
                    height: 50 * scale,
                  ),
                ),
                Positioned(
                  right: 11 * scale,
                  top: 457 * scale,
                  child: _buildFeatureTagWidget(
                    icon: AppIcons.icChartUp,
                    label: StringConst.welcomeCashflowTag,
                    width: 202 * scale,
                    height: 40 * scale,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: height * 0.36,
                  child: _buildBottomSheetWidget(onNext: () => _goHome(context), onSkip: () => _goHome(context)),
                ),
              ],
            );
          },
        ),
      );

  Widget _buildHeroImageWidget() {
    return Image.asset(AppIcons.imgWelcomeHero, fit: .cover, width: .infinity, height: .infinity);
  }

  Widget _buildFeatureTagWidget({
    required String icon,
    required String label,
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      padding: .symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: .circular(12),
        boxShadow: [BoxShadow(color: AppColors.blackColor.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: height - 12,
            height: height - 12,
            decoration: BoxDecoration(color: AppColors.neutral200Color, borderRadius: .circular(8)),
            alignment: .center,
            child: SvgPicture.asset(icon, width: 18, height: 18, colorFilter: .mode(AppColors.blackColor, .srcIn)),
          ),
          Expanded(child: Text(label, style: AppTextStyles.welcomeTag, maxLines: 2, overflow: .ellipsis)),
        ],
      ),
    );
  }

  Widget _buildBottomSheetWidget({required VoidCallback onNext, required VoidCallback onSkip}) {
    return Container(
      width: .infinity,
      padding: .fromLTRB(51, 20, 51, 34),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: .vertical(top: .circular(32)),
      ),
      child: Column(
        spacing: 14,
        children: [
          Column(
            spacing: 20,
            children: [
              _buildPageIndicatorWidget(),
              Column(
                spacing: 14,
                children: [
                  Text(StringConst.welcomeTitle, style: AppTextStyles.welcomeTitle, textAlign: .center),
                  Text(StringConst.welcomeSubtitle, style: AppTextStyles.welcomeSubtitle, textAlign: .center),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            spacing: 10,
            children: [
              _buildPrimaryButtonWidget(label: StringConst.next, onTap: onNext),
              _buildSecondaryButtonWidget(label: StringConst.skip, onTap: onSkip),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicatorWidget() {
    return Row(
      mainAxisAlignment: .center,
      spacing: 6,
      children: [
        Container(width: 16, height: 6, decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: .circular(999))),
        Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.dividerColor, shape: .circle)),
        Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.dividerColor, shape: .circle)),
      ],
    );
  }

  Widget _buildPrimaryButtonWidget({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: .infinity,
        height: 44,
        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: .circular(10)),
        alignment: .center,
        child: Text(label, style: AppTextStyles.welcomePrimaryButton),
      ),
    );
  }

  Widget _buildSecondaryButtonWidget({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: .infinity,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: .circular(10),
          border: .all(color: AppColors.blackColor, width: 1),
        ),
        alignment: .center,
        child: Text(label, style: AppTextStyles.welcomeSecondaryButton),
      ),
    );
  }
}
