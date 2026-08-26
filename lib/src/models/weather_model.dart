import 'current_model.dart';
import 'forecast_model.dart';
import 'location_model.dart';

class WeatherModel {
  final LocationModel location;
  final CurrentModel current;
  final ForecastModel forecast;

  WeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return WeatherModel(
        location: LocationModel.empty(),
        current: CurrentModel.empty(),
        forecast: ForecastModel(forecastday: []),
      );
    }
    return WeatherModel(
      location: LocationModel.fromJson(json['location']),
      current: CurrentModel.fromJson(json['current']),
      forecast: ForecastModel.fromJson(json['forecast']),
    );
  }
}
