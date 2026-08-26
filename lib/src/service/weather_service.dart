import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../exceptions/api_exceptions.dart';
import '../constants/app_constants.dart';
import '../models/weather_model.dart';

class WeatherService {
  // Initialize Dio instance (you can also configure a base options instance globally)
  final Dio _dio = Dio();

  Future<WeatherModel> getForecast(String city, int days) async {
    try {
      // Dio automatically appends query parameters cleanly
      final response = await _dio.get(
        AppConstants.baseUrl,
        queryParameters: {
          'key': AppConstants.apiKey,
          'q': city,
          'days': days,
          'aqi': 'yes',
          'alerts': 'no',
        },
      );

      final dynamic jsonData = response.data;

      // Log status + body for debugging
      debugPrint('WeatherService.getForecast -> status=${response.statusCode}');
      final bodyStr = jsonData.toString();
      debugPrint(
        'WeatherService.getForecast -> body=${bodyStr.length > 1000 ? "${bodyStr.substring(0, 1000)}.,,(truncated)" : bodyStr}',
      );

      // Defensive checks and clearer error messages
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
        return WeatherModel.fromJson(jsonData);
      } catch (e) {
        // Parsing error -> provide informative message
        throw ApiException('Failed to parse weather data.');
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors (network failures, bad status codes, timeouts)
      if (e.response != null) {
        final responseData = e.response?.data;
        final shortBody = responseData != null ? responseData.toString() : '';
        final truncatedBody = shortBody.length > 200
            ? '${shortBody.substring(0, 200)}...(truncated)'
            : shortBody;

        throw ApiException(
          'Request failed (status ${e.response?.statusCode}). $truncatedBody',
        );
      } else {
        // Connection errors, timeouts, etc.
        throw ApiException('Network error: ${e.message}');
      }
    } catch (e) {
      // Re-throw if it's already an ApiException
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error occurred: $e');
    }
  }
}
