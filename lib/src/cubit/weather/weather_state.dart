import '../../models/weather_model.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  final String selectedCity;

  const WeatherLoaded({required this.weather, required this.selectedCity});

  WeatherLoaded copyWith({WeatherModel? weather, String? selectedCity}) {
    return WeatherLoaded(
      weather: weather ?? this.weather,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);
}
