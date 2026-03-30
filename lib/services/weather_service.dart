import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_models.dart';

/// Custom API exception so callers can map to user-friendly messages.
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}

class WeatherService {
  final String _apikey = '976085ed68464f0c84b194704250509';
  final String _baseurl = 'https://api.weatherapi.com/v1/forecast.json';

  Future<WeatherData> getForecast(String city, int days) async {
    final url = Uri.parse(
      '$_baseurl?key=$_apikey&q=$city&days=$days&aqi=yes&alerts=no',
    );

    final response = await http.get(url);
    final body = response.body;
    // log status + body for debugging
    debugPrint('WeatherService.getForecast -> status=${response.statusCode}');
    debugPrint(
      'WeatherService.getForecast -> body=${body.length > 1000 ? "${body.substring(0, 1000)}.,,(truncated)" : body}',
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(body);
      // defensive checks and clearer error messages
      if (jsonData == null) {
        throw ApiException('Invalid server response (empty).');
      }
      if (jsonData is! Map<String, dynamic>) {
        throw ApiException('Invalid server response (unexpected format).');
      }
      if (jsonData.containsKey('error')) {
        final err = jsonData['error'];
        final msg = (err is Map && err.containsKey('message'))
            ? err['message']
            : err.toString();
        throw ApiException('API error: $msg');
      }
      try {
        return WeatherData.fromJson(jsonData);
      } catch (e) {
        // parsing error -> provide informative message
        throw ApiException('Failed to parse weather data.');
      }
    } else {
      // non-200 -> include status and short body for diagnostics
      final shortBody = body.length > 200
          ? '${body.substring(0, 200)}...(truncated)'
          : body;
      throw ApiException(
        'Request failed (status ${response.statusCode}). $shortBody',
      );
    }
  }
}
