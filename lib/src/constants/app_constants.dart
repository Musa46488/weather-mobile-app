import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppConstants {
  AppConstants._();
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
