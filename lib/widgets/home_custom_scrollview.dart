import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/widgets/drop_down_menu.dart';
import 'package:weather_app/helpers/responsive_helper.dart';

class HomeCustomScrollView extends StatelessWidget {
  final WeatherController controller;

  const HomeCustomScrollView({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = controller.weather;
    final selectedCity = controller.selectedCity;

    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.widthPercentage(context, 0.06),
                vertical: Responsive.heightPercentage(context, 0.18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CityDropdown(
                    selectedCity: selectedCity,
                    onSelected: (newCity) {
                      controller.loadWeather(newCity, context);
                    },
                  ),
                  SizedBox(height: Responsive.heightPercentage(context, 0.01)),
                  Text(
                    "${weather?.current.tempC.toStringAsFixed(0) ?? "--"}°",
                    style: TextStyle(
                      color: AppColors.whiteTextColor,
                      fontSize: Responsive.fontSize(
                        context,
                        mobile: 64,
                        tablet: 72,
                        desktop: 80,
                      ),
                    ),
                  ),
                  Text(
                    weather?.current.condition.text.toString() ?? "",
                    style: TextStyle(
                      color: AppColors.lightToneTextColor,
                      fontSize: Responsive.fontSize(
                        context,
                        mobile: 18,
                        tablet: 20,
                        desktop: 22,
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.heightPercentage(context, 0.005)),
                  Text(
                    "H:${weather?.forecast.forecastday[0].day.maxtempC.toStringAsFixed(0) ?? "--"}°  L:${weather?.forecast.forecastday[0].day.mintempC.toStringAsFixed(0) ?? "--"}°",
                    style: TextStyle(
                      color: AppColors.whiteTextColor,
                      fontSize: Responsive.fontSize(
                        context,
                        mobile: 16,
                        tablet: 18,
                        desktop: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
