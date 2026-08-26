import '../models/weather_model.dart';
import '../service/weather_service.dart';

class WeatherRepository {
  final WeatherService _service;

  WeatherRepository(this._service);

  Future<WeatherModel> getForecast(String city, int days) async {
    return await _service.getForecast(city, days);
  }
}
