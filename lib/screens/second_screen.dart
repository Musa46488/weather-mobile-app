import 'package:flutter/material.dart';
import 'package:weather_app/cards/air_quality_card.dart';
import 'package:weather_app/cards/info_card.dart';
import 'package:weather_app/constants/app_images.dart';
import 'package:weather_app/helpers/responsive_helper.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/widgets/forecast_toggle_section.dart';

class SecondScreen extends StatefulWidget {
  final WeatherData weather;
  const SecondScreen({super.key, required this.weather});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late double _airQualityValue;

  @override
  void initState() {
    super.initState();
    _airQualityValue = widget.weather.current.airQuality.usEpaIndex.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final weather = widget.weather;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImages.backgroundImage, fit: BoxFit.cover),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.widthPercentage(context, 0.04),
                vertical: Responsive.heightPercentage(context, 0.02),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: Responsive.dimension(
                        context,
                        mobile: 24,
                        tablet: 28,
                        desktop: 32,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          weather.location.name,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(
                              context,
                              mobile: 28,
                              tablet: 32,
                              desktop: 36,
                            ),
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: Responsive.heightPercentage(context, 0.01),
                        ),
                        Text(
                          '${weather.current.tempC.toStringAsFixed(0)}° | ${weather.current.condition.text}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: Responsive.fontSize(
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
                  SizedBox(height: Responsive.heightPercentage(context, 0.04)),

                  ForecastToggleSection(
                    hourlyForecast: weather.forecast.forecastday[0].hour,
                    dailyForecast: weather.forecast.forecastday,
                  ),

                  SizedBox(height: Responsive.heightPercentage(context, 0.02)),

                  // Air Quality Card
                  AirQualityCard(
                    airQualityValue: _airQualityValue,
                    onChanged: (value) {
                      setState(() {
                        _airQualityValue = value;
                      });
                    },
                    labelBuilder: _getAirQualityLabel,
                  ),

                  SizedBox(height: Responsive.heightPercentage(context, 0.02)),

                  // Info Cards Grid
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisCount = Responsive.isMobile(context)
                            ? 2
                            : 3;
                        final childAspectRatio = Responsive.isMobile(context)
                            ? (constraints.maxWidth / crossAxisCount) / 120
                            : (constraints.maxHeight / crossAxisCount) / 100;
                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: Responsive.widthPercentage(
                            context,
                            0.02,
                          ),
                          mainAxisSpacing: Responsive.heightPercentage(
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
                              value:
                                  weather.forecast.forecastday[0].astro.sunrise,
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
                              value: weather.current.humidity.toStringAsFixed(
                                0,
                              ),
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
  }

  String _getAirQualityLabel(double value) {
    switch (value.toInt()) {
      case 0:
      case 1:
        return "Good";
      case 2:
      case 3:
        return "Low Health Risk";
      case 4:
        return "Moderate Risk";
      case 5:
        return "High Risk";
      default:
        return "Unknown";
    }
  }
}
