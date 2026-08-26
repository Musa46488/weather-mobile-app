import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import '../cubit/weather/weather_cubit.dart';
import '../cubit/weather/weather_state.dart';
import '../helpers/helper_functions.dart';
import '../helpers/responsive_helper.dart';
import '../widgets/air_quality_card.dart';
import '../widgets/forecast_toggle_section.dart';
import '../widgets/info_card.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is WeatherError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        if (state is! WeatherLoaded) {
          return const Scaffold(
            body: Center(child: Text("No weather data available.")),
          );
        }

        final weather = state.weather;
        final airQualityValue = weather.current.airQuality.usEpaIndex
            .toDouble();

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppImages.backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.widthPercentage(context, 0.04),
                    vertical: ResponsiveHelper.heightPercentage(context, 0.02),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.whiteColor,
                          size: ResponsiveHelper.dimension(
                            context,
                            mobile: 24,
                            tablet: 28,
                            desktop: 32,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),

                      Center(
                        child: Column(
                          children: [
                            Text(
                              weather.location.name,
                              style: TextStyle(
                                fontSize: ResponsiveHelper.fontSize(
                                  context,
                                  mobile: 28,
                                  tablet: 32,
                                  desktop: 36,
                                ),
                                color: AppColors.whiteColor,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(
                              height: ResponsiveHelper.heightPercentage(
                                context,
                                0.01,
                              ),
                            ),

                            Text(
                              "${weather.current.tempC.toStringAsFixed(0)}° | ${weather.current.condition.text}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: ResponsiveHelper.fontSize(
                                  context,
                                  mobile: 16,
                                  tablet: 18,
                                  desktop: 20,
                                ),
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: ResponsiveHelper.heightPercentage(
                          context,
                          0.04,
                        ),
                      ),

                      ForecastToggleSection(
                        hourlyForecast: weather.forecast.forecastday[0].hour,
                        dailyForecast: weather.forecast.forecastday,
                      ),

                      SizedBox(
                        height: ResponsiveHelper.heightPercentage(
                          context,
                          0.02,
                        ),
                      ),

                      AirQualityCard(
                        airQualityValue: airQualityValue,
                        labelBuilder: HelperFunctions.getAirQualityLabel,
                      ),

                      SizedBox(
                        height: ResponsiveHelper.heightPercentage(
                          context,
                          0.02,
                        ),
                      ),

                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final crossAxisCount =
                                ResponsiveHelper.isMobile(context) ? 2 : 3;

                            final childAspectRatio =
                                ResponsiveHelper.isMobile(context)
                                ? (constraints.maxWidth / crossAxisCount) / 120
                                : (constraints.maxHeight / crossAxisCount) /
                                      100;

                            return GridView.count(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing:
                                  ResponsiveHelper.widthPercentage(
                                    context,
                                    0.02,
                                  ),
                              mainAxisSpacing:
                                  ResponsiveHelper.heightPercentage(
                                    context,
                                    0.015,
                                  ),
                              childAspectRatio: childAspectRatio,
                              children: [
                                InfoCard(
                                  title: "UV Index",
                                  value: weather.current.uv.toString(),
                                  subtitle: "Moderate",
                                ),

                                InfoCard(
                                  title: "Sunrise",
                                  value: weather
                                      .forecast
                                      .forecastday[0]
                                      .astro
                                      .sunrise,
                                  subtitle:
                                      "Sunset: ${weather.forecast.forecastday[0].astro.sunset}",
                                ),

                                InfoCard(
                                  title: "Wind",
                                  value:
                                      "${weather.current.windKph.toStringAsFixed(1)} km/h",
                                  subtitle: weather.current.windDir,
                                ),

                                InfoCard(
                                  title: "Humidity",
                                  value: weather.current.humidity
                                      .toStringAsFixed(0),
                                  subtitle:
                                      "Clouds: ${weather.current.cloud.toStringAsFixed(0)}",
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
