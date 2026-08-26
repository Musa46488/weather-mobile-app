import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_colors.dart';
import '../cubit/weather/weather_cubit.dart';
import '../models/weather_model.dart';
import '../widgets/drop_down_menu.dart';
import '../helpers/responsive_helper.dart';

class HomeCustomScrollView extends StatelessWidget {
  final WeatherModel? weather;
  final String selectedCity;

  const HomeCustomScrollView({
    super.key,
    required this.weather,
    required this.selectedCity,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WeatherCubit>();

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.widthPercentage(context, 0.06),
                vertical: ResponsiveHelper.heightPercentage(context, 0.18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CityDropdown(
                    selectedCity: selectedCity,
                    onSelected: (newCity) {
                      cubit.loadWeather(newCity);
                    },
                  ),

                  SizedBox(
                    height: ResponsiveHelper.heightPercentage(context, 0.01),
                  ),

                  Text(
                    "${weather?.current.tempC.toStringAsFixed(0) ?? "--"}°",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: ResponsiveHelper.fontSize(
                        context,
                        mobile: 64,
                        tablet: 72,
                        desktop: 80,
                      ),
                    ),
                  ),

                  Text(
                    weather?.current.condition.text ?? "",
                    style: TextStyle(
                      color: AppColors.lightToneColor,
                      fontSize: ResponsiveHelper.fontSize(
                        context,
                        mobile: 18,
                        tablet: 20,
                        desktop: 22,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: ResponsiveHelper.heightPercentage(context, 0.005),
                  ),

                  Text(
                    "H:${weather?.forecast.forecastday[0].day.maxtempC.toStringAsFixed(0) ?? "--"}°  "
                    "L:${weather?.forecast.forecastday[0].day.mintempC.toStringAsFixed(0) ?? "--"}°",
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
            ),
          ),
        ),
      ],
    );
  }
}
