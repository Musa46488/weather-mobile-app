import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../cubit/forecast_toggle/forecast_toggle_state.dart';
import '../cubit/forecast_toggle/forecast_toggle_cubit.dart';
import '../helpers/helper_functions.dart';
import '../helpers/responsive_helper.dart';
import '../models/forecast_day_model.dart';
import '../models/hour_model.dart';
import 'hourly_forecast_card.dart';
import 'weekly_forecast_card.dart';

class ForecastToggleSection extends StatelessWidget {
  final List<HourModel>? hourlyForecast;
  final List<ForecastDayModel>? dailyForecast;

  const ForecastToggleSection({
    super.key,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  @override
  Widget build(BuildContext context) {
    final hourly = hourlyForecast ?? [];
    final daily = dailyForecast ?? [];

    return BlocBuilder<ForecastToggleCubit, ForecastToggleState>(
      builder: (context, state) {
        final isHourly = state is HourlyForecastState;

        return Column(
          children: [
            // Toggle Buttons
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.widthPercentage(context, 0.01),
                vertical: ResponsiveHelper.heightPercentage(context, 0.005),
              ),
              child: Row(
                children: [
                  /// Hourly Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<ForecastToggleCubit>().showHourly();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveHelper.heightPercentage(
                            context,
                            0.012,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: isHourly
                              ? AppColors.whiteColor.withValues(alpha: 0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Hourly Forecast",
                          style: TextStyle(
                            color: isHourly
                                ? AppColors.whiteColor
                                : Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveHelper.fontSize(
                              context,
                              mobile: 14,
                              tablet: 16,
                              desktop: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Weekly Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<ForecastToggleCubit>().showWeekly();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveHelper.heightPercentage(
                            context,
                            0.012,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: !isHourly
                              ? AppColors.whiteColor.withValues(alpha: 0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Weekly Forecast",
                          style: TextStyle(
                            color: !isHourly
                                ? AppColors.whiteColor
                                : Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveHelper.fontSize(
                              context,
                              mobile: 14,
                              tablet: 16,
                              desktop: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveHelper.heightPercentage(context, 0.02)),

            /// Forecast Cards
            isHourly
                ? SizedBox(
                    height: ResponsiveHelper.heightPercentage(context, 0.18),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hourly.length.clamp(0, 24),
                      itemBuilder: (context, index) {
                        final hourData = hourly[index];

                        return HourlyForecastCard(
                          time: HelperFunctions.formatHour(
                            hourData.time,
                            index,
                          ),
                          temperature: "${hourData.tempC.round()}°",
                          iconPath: AppIcons.weatherIcon,
                          rainChance: hourData.chanceOfRain,
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: ResponsiveHelper.heightPercentage(context, 0.18),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: daily.length,
                      itemBuilder: (context, index) {
                        final dayData = daily[index];

                        return WeeklyForecastCard(
                          day: HelperFunctions.getWeekdayLabel(dayData.date),
                          highTemp: "${dayData.day.maxtempC.round()}°",
                          lowTemp: "${dayData.day.mintempC.round()}°",
                          iconPath: AppIcons.weatherIcon,
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}
