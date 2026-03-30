import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_models.dart';

class WeatherController extends ChangeNotifier {
  WeatherData? weather;
  String selectedCity = 'Lahore';
  bool loading = false;

  final WeatherService _service = WeatherService();

  Future<void> loadWeather([String? city, BuildContext? context]) async {
    final c = city ?? selectedCity;
    try {
      loading = true;
      notifyListeners();
      final data = await _service.getForecast(c, 3);
      weather = data;
      selectedCity = c;
    } on ApiException catch (e) {
      debugPrint('WeatherController: ApiException -> $e');
      if (context != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } on http.ClientException catch (e) {
      debugPrint('WeatherController: ClientException -> $e');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Network error — check your connection.'),
          ),
        );
      }
    } catch (e, st) {
      debugPrint('WeatherController: unexpected error -> $e\n$st');
      final msg = _mapErrorToMessage(e);
      if (context != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  String _mapErrorToMessage(Object e) {
    if (e is ApiException) return e.message;
    if (e is FormatException) return 'Invalid response from server.';
    if (e is http.ClientException) {
      return 'Network error — check your connection.';
    }
    return 'Something went wrong. Please try again.';
  }
}
