import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/cubit/forecast_toggle/forecast_toggle_cubit.dart';

import 'src/cubit/weather/weather_cubit.dart';
import 'src/repository/weather_repository.dart';
import 'src/service/weather_service.dart';
import 'src/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => WeatherRepository(WeatherService())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                WeatherCubit(context.read<WeatherRepository>())..loadWeather(),
          ),
          BlocProvider(create: (_) => ForecastToggleCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
