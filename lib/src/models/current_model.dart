import '../helpers/helper_functions.dart';
import 'air_quality_model.dart';
import 'condition_model.dart';

class CurrentModel {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final bool isDay;
  final ConditionModel condition;
  final double windKph;
  final String windDir;
  final double pressureMb;
  final double humidity;
  final double cloud;
  final double feelslikeC;
  final double uv;
  final AirQualityModel airQuality;

  CurrentModel({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.windDir,
    required this.pressureMb,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.uv,
    required this.airQuality,
  });

  factory CurrentModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return CurrentModel.empty();
    }
    return CurrentModel(
      lastUpdatedEpoch: HelperFunctions.toInt(json['last_updated_epoch']),
      lastUpdated: HelperFunctions.toStrings(json['last_updated']),
      tempC: HelperFunctions.toDouble(json['temp_c']),
      isDay: HelperFunctions.toInt(json['is_day']) == 1,
      condition: ConditionModel.fromJson(json['condition']),
      windKph: HelperFunctions.toDouble(json['wind_kph']),
      windDir: HelperFunctions.toStrings(json['wind_dir']),
      pressureMb: HelperFunctions.toDouble(json['pressure_mb']),
      humidity: HelperFunctions.toDouble(json['humidity']),
      cloud: HelperFunctions.toDouble(json['cloud']),
      feelslikeC: HelperFunctions.toDouble(json['feelslike_c']),
      uv: HelperFunctions.toDouble(json['uv']),
      airQuality: AirQualityModel.fromJson(json['air_quality']),
    );
  }

  factory CurrentModel.empty() => CurrentModel(
    lastUpdatedEpoch: 0,
    lastUpdated: '',
    tempC: 0,
    isDay: false,
    condition: ConditionModel.empty(),
    windKph: 0,
    windDir: '',
    pressureMb: 0,
    humidity: 0,
    cloud: 0,
    feelslikeC: 0,
    uv: 0,
    airQuality: AirQualityModel.empty(),
  );
}
