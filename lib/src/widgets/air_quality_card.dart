import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../helpers/responsive_helper.dart';

class AirQualityCard extends StatelessWidget {
  final double airQualityValue;
  final String Function(double) labelBuilder;

  const AirQualityCard({
    super.key,
    required this.airQualityValue,
    required this.labelBuilder,
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
        children: [
          Text(
            "Air Quality",
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: ResponsiveHelper.fontSize(
                context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ResponsiveHelper.heightPercentage(context, 0.005)),
          Text(
            "${airQualityValue.toInt()} - ${labelBuilder(airQualityValue)}",
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
          SizedBox(height: ResponsiveHelper.heightPercentage(context, 0.01)),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              // Forces the track and thumb to remain red even when onChanged is null
              disabledActiveTrackColor: AppColors.redColor.withValues(
                alpha: 0.3,
              ),
              disabledThumbColor: AppColors.redColor,
            ),
            child: Slider(
              value: airQualityValue,
              min: 0,
              max: 5,
              divisions: 5,
              label: airQualityValue.toInt().toString(),
              onChanged: null,
            ),
          ),
          SizedBox(height: ResponsiveHelper.heightPercentage(context, 0.005)),
          Text(
            "See more",
            style: TextStyle(
              color: Colors.white70,
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
