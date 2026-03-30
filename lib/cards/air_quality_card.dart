import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/helpers/responsive_helper.dart';

class AirQualityCard extends StatelessWidget {
  final double airQualityValue;
  final ValueChanged<double> onChanged;
  final String Function(double) labelBuilder;

  const AirQualityCard({
    super.key,
    required this.airQualityValue,
    required this.onChanged,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        Responsive.dimension(context, mobile: 12, tablet: 16, desktop: 20),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Air Quality",
            style: TextStyle(
              color: AppColors.whiteTextColor,
              fontSize: Responsive.fontSize(
                context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.heightPercentage(context, 0.005)),
          Text(
            "${airQualityValue.toInt()} - ${labelBuilder(airQualityValue)}",
            style: TextStyle(
              color: AppColors.whiteTextColor,
              fontSize: Responsive.fontSize(
                context,
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
            ),
          ),
          SizedBox(height: Responsive.heightPercentage(context, 0.01)),
          Slider(
            value: airQualityValue,
            min: 0,
            max: 5,
            divisions: 5,
            label: airQualityValue.toInt().toString(),
            activeColor: AppColors.navBarCenterColor.withOpacity(0.8),
            inactiveColor: Colors.white24,
            onChanged: onChanged,
          ),
          SizedBox(height: Responsive.heightPercentage(context, 0.005)),
          Text(
            "See more",
            style: TextStyle(
              color: Colors.white70,
              fontSize: Responsive.fontSize(
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
