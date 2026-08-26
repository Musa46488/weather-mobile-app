import 'dart:ui';

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../helpers/responsive_helper.dart';
import '../models/weather_model.dart';
import '../widgets/forecast_toggle_section.dart';

class BottomPanel extends StatelessWidget {
  final WeatherModel? weather;

  const BottomPanel({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ResponsiveHelper.heightPercentage(context, 0.08),
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: const Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.widthPercentage(context, 0.06),
              vertical: ResponsiveHelper.heightPercentage(context, 0.02),
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              border: Border.all(
                color: AppColors.whiteColor.withValues(alpha: 0.2),
              ),
            ),
            height: ResponsiveHelper.heightPercentage(context, 0.35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: ResponsiveHelper.widthPercentage(context, 0.1),
                    height: ResponsiveHelper.heightPercentage(context, 0.005),
                    margin: EdgeInsets.only(
                      bottom: ResponsiveHelper.heightPercentage(context, 0.02),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                Expanded(
                  child: weather == null
                      ? const Center(child: CircularProgressIndicator())
                      : ForecastToggleSection(
                          hourlyForecast: weather!.forecast.forecastday[0].hour,
                          dailyForecast: weather!.forecast.forecastday,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
