import 'package:dio/dio.dart';
import '../exceptions/api_exceptions.dart';

abstract class HelperFunctions {
  HelperFunctions._();
  static double toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    final parsed = double.tryParse(value.toString());
    return parsed ?? 0.0;
  }

  static int toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static String toStrings(dynamic value) => value?.toString() ?? '';

  static String formatHour(String fullTime, int index) {
    try {
      final time = DateTime.parse(fullTime);
      if (index == 0) return "Now";
      final hour = time.hour;
      final formatted = hour == 0
          ? "12 AM"
          : hour < 12
          ? "$hour AM"
          : hour == 12
          ? "12 PM"
          : "${hour - 12} PM";
      return formatted;
    } catch (_) {
      return "--";
    }
  }

  static String getWeekdayLabel(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday %
          7];
    } catch (_) {
      return '--';
    }
  }

  static String mapErrorToMessage(Object e) {
    if (e is ApiException) return e.message;
    if (e is FormatException) return 'Invalid response from server.';
    if (e is DioException) {
      // 🔴 Handle DioException mappings here too
      return 'Network error — check your connection.';
    }
    return 'Something went wrong. Please try again.';
  }

  static String getAirQualityLabel(double value) {
    switch (value.toInt()) {
      case 0:
      case 1:
        return "Good";
      case 2:
      case 3:
        return "Low Health Risk";
      case 4:
        return "Moderate Risk";
      case 5:
        return "High Risk";
      default:
        return "Unknown";
    }
  }
}
