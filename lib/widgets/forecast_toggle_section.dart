import 'package:flutter/material.dart';
import 'package:weather_app/cards/hourly_forecast_card.dart';
import 'package:weather_app/cards/weekly_forecast_card.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_images.dart';
import 'package:weather_app/helpers/responsive_helper.dart';
import 'package:weather_app/models/weather_models.dart';

class ForecastToggleSection extends StatefulWidget {
  final List<Hour>? hourlyForecast;
  final List<ForecastDay>? dailyForecast;

  const ForecastToggleSection({
    super.key,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  @override
  State<ForecastToggleSection> createState() => _ForecastToggleSectionState();
}

class _ForecastToggleSectionState extends State<ForecastToggleSection> {
  bool _showHourly = true;

  @override
  Widget build(BuildContext context) {
    final hourly = widget.hourlyForecast ?? [];
    final daily = widget.dailyForecast ?? [];

    return Column(
      children: [
        // Toggle Buttons
        Container(
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.widthPercentage(context, 0.01),
            vertical: Responsive.heightPercentage(context, 0.005),
          ),
          child: Row(
            children: [
              // Hourly Button
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showHourly = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Responsive.heightPercentage(context, 0.012),
                    ),
                    decoration: BoxDecoration(
                      color: _showHourly
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Hourly Forecast",
                      style: TextStyle(
                        color: _showHourly
                            ? AppColors.whiteTextColor
                            : Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: Responsive.fontSize(
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

              // Weekly Button
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showHourly = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Responsive.heightPercentage(context, 0.012),
                    ),
                    decoration: BoxDecoration(
                      color: !_showHourly
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Weekly Forecast",
                      style: TextStyle(
                        color: !_showHourly
                            ? AppColors.whiteTextColor
                            : Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: Responsive.fontSize(
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

        SizedBox(height: Responsive.heightPercentage(context, 0.02)),

        // Forecast Cards Section
        _showHourly
            ? SizedBox(
                height: Responsive.heightPercentage(context, 0.15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hourly.length.clamp(0, 24),
                  itemBuilder: (context, index) {
                    final hourData = hourly[index];
                    return HourlyForecastCard(
                      time: _formatHour(hourData.time, index),
                      temperature: "${hourData.tempC.round()}°",
                      iconPath: AppImages.weatherIcon,
                      rainChance: hourData.chanceOfRain,
                    );
                  },
                ),
              )
            : SizedBox(
                height: Responsive.heightPercentage(context, 0.18),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: daily.length,
                  itemBuilder: (context, index) {
                    final dayData = daily[index];
                    return WeeklyForecastCard(
                      day: _getWeekdayLabel(dayData.date),
                      highTemp: "${dayData.day.maxtempC.round()}°",
                      lowTemp: "${dayData.day.mintempC.round()}°",
                      iconPath: AppImages.weatherIcon,
                    );
                  },
                ),
              ),
      ],
    );
  }

  String _formatHour(String fullTime, int index) {
    try {
      final time = DateTime.parse(fullTime);
      if (index == 0) return "Now";
      final hour = time.hour;
      final formatted = hour == 0
          ? "12 AM"
          : hour < 12
          ? "$hour AM"
          : hour == 12
          ? "12 PM"
          : "${hour - 12} PM";
      return formatted;
    } catch (_) {
      return "--";
    }
  }

  String _getWeekdayLabel(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday %
          7];
    } catch (_) {
      return '--';
    }
  }
}
