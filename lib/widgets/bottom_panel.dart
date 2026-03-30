import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/helpers/responsive_helper.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/widgets/forecast_toggle_section.dart';

class BottomPanel extends StatelessWidget {
  final WeatherData? weather;

  const BottomPanel({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: Responsive.heightPercentage(context, 0.08),
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: const Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.widthPercentage(context, 0.06),
              vertical: Responsive.heightPercentage(context, 0.02),
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            height: Responsive.heightPercentage(context, 0.35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: Responsive.widthPercentage(context, 0.1),
                    height: Responsive.heightPercentage(context, 0.005),
                    margin: EdgeInsets.only(
                      bottom: Responsive.heightPercentage(context, 0.02),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.handleBarColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                if (weather != null)
                  ForecastToggleSection(
                    hourlyForecast: weather!.forecast.forecastday[0].hour,
                    dailyForecast: weather!.forecast.forecastday,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
