import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/weather_model.dart';

import '../constants/app_images.dart';
import '../cubit/weather/weather_cubit.dart';
import '../cubit/weather/weather_state.dart';

import '../widgets/bottom_panel.dart';
import '../widgets/home_bottom_navigation_bar.dart';
import '../widgets/home_custom_scrollview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state is WeatherError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      builder: (context, state) {
        WeatherModel? weather;
        String selectedCity = "Lahore";

        if (state is WeatherLoaded) {
          weather = state.weather;
          selectedCity = state.selectedCity;
        }

        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      AppImages.backgroundImage,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SafeArea(
                    child: RefreshIndicator(
                      onRefresh: () {
                        final state = context.read<WeatherCubit>().state;

                        if (state is WeatherLoaded) {
                          return context.read<WeatherCubit>().loadWeather(
                            state.selectedCity,
                          );
                        }

                        return context.read<WeatherCubit>().loadWeather();
                      },
                      child: HomeCustomScrollView(
                        weather: weather,
                        selectedCity: selectedCity,
                      ),
                    ),
                  ),

                  BottomPanel(weather: weather),

                  HomeBottomNavigationBar(weather: weather),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
