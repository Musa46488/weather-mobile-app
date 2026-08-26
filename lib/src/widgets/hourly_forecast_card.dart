import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../helpers/responsive_helper.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String temperature;
  final String iconPath;
  final int? rainChance;
  final Color? backgroundColor;

  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.temperature,
    required this.iconPath,
    this.rainChance,
    this.backgroundColor,
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
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.widthPercentage(context, 0.01),
      ),
      padding: EdgeInsets.all(
        ResponsiveHelper.dimension(
          context,
          mobile: 10,
          tablet: 12,
          desktop: 14,
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.whiteColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            time,
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
          Image.asset(
            iconPath,
            width: ResponsiveHelper.dimension(
              context,
              mobile: 32,
              tablet: 36,
              desktop: 40,
            ),
            height: ResponsiveHelper.dimension(
              context,
              mobile: 32,
              tablet: 36,
              desktop: 40,
            ),
          ),
          if (rainChance != 0)
            Text(
              '$rainChance %',
              style: TextStyle(
                color: AppColors.cyanColor,
                fontSize: ResponsiveHelper.fontSize(
                  context,
                  mobile: 12,
                  tablet: 14,
                  desktop: 16,
                ),
              ),
            ),
          Text(
            temperature,
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
        ],
      ),
    );
  }
}
