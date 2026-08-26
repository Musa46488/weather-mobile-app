import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../helpers/responsive_helper.dart';

class WeeklyForecastCard extends StatelessWidget {
  final String day;
  final String highTemp;
  final String lowTemp;
  final String iconPath;

  const WeeklyForecastCard({
    required this.day,
    required this.highTemp,
    required this.lowTemp,
    required this.iconPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.dimension(
        context,
        mobile: 70,
        tablet: 80,
        desktop: 90,
      ),
      margin: EdgeInsets.only(
        right: ResponsiveHelper.widthPercentage(context, 0.03),
      ),
      padding: EdgeInsets.all(
        ResponsiveHelper.dimension(
          context,
          mobile: 12,
          tablet: 14,
          desktop: 16,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
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

          Image.asset(
            iconPath,
            width: ResponsiveHelper.dimension(
              context,
              mobile: 40,
              tablet: 45,
              desktop: 50,
            ),
            height: ResponsiveHelper.dimension(
              context,
              mobile: 40,
              tablet: 45,
              desktop: 50,
            ),
            fit: BoxFit.contain,
          ),

          Text(
            'H: $highTemp',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: ResponsiveHelper.fontSize(
                context,
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
            ),
          ),
          Text(
            'L: $lowTemp',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: ResponsiveHelper.fontSize(
                context,
                mobile: 14,
                tablet: 16,
                desktop: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
