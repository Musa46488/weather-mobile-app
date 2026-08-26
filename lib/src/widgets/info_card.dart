import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../helpers/responsive_helper.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        ResponsiveHelper.dimension(
          context,
          mobile: 12,
          tablet: 16,
          desktop: 20,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: ResponsiveHelper.fontSize(
                context,
                mobile: 18,
                tablet: 20,
                desktop: 22,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ResponsiveHelper.heightPercentage(context, 0.005)),
          Text(
            value,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: ResponsiveHelper.fontSize(
                context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white54,
              fontSize: ResponsiveHelper.fontSize(
                context,
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
