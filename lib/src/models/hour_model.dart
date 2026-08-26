import '../helpers/helper_functions.dart';

import 'air_quality_model.dart';
import 'condition_model.dart';

class HourModel {
  final String time;
  final double tempC;
  final bool isDay;
  final ConditionModel condition;
  final double windKph;
  final double pressureMb;
  final double humidity;
  final double cloud;
  final double feelslikeC;
  final double uv;
  final AirQualityModel airQuality;
  final int chanceOfRain;
  final int willItRain;
  final int willItSnow;
  final int chanceOfSnow;
  final double visKm;

  HourModel({
    required this.time,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.pressureMb,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.uv,
    required this.airQuality,
    required this.chanceOfRain,
    required this.willItRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.visKm,
  });

  factory HourModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return HourModel.empty();
    }
    return HourModel(
      time: HelperFunctions.toStrings(json['time']),
      tempC: HelperFunctions.toDouble(json['temp_c']),
      isDay: HelperFunctions.toInt(json['is_day']) == 1,
      condition: ConditionModel.fromJson(json['condition']),
      windKph: HelperFunctions.toDouble(json['wind_kph']),
      pressureMb: HelperFunctions.toDouble(json['pressure_mb']),
      humidity: HelperFunctions.toDouble(json['humidity']),
      cloud: HelperFunctions.toDouble(json['cloud']),
      feelslikeC: HelperFunctions.toDouble(json['feelslike_c']),
      uv: HelperFunctions.toDouble(json['uv']),
      airQuality: AirQualityModel.fromJson(json['air_quality']),
      chanceOfRain: HelperFunctions.toInt(
        json['chance_of_rain'] ?? json['chance_of_rain_pct'],
      ),
      willItRain: HelperFunctions.toInt(json['will_it_rain']),
      willItSnow: HelperFunctions.toInt(json['will_it_snow']),
      chanceOfSnow: HelperFunctions.toInt(json['chance_of_snow']),
      visKm: HelperFunctions.toDouble(json['vis_km']),
    );
  }

  factory HourModel.empty() => HourModel(
    time: '',
    tempC: 0,
    isDay: false,
    condition: ConditionModel.empty(),
    windKph: 0,
    pressureMb: 0,
    humidity: 0,
    cloud: 0,
    feelslikeC: 0,
    uv: 0,
    airQuality: AirQualityModel.empty(),
    chanceOfRain: 0,
    willItRain: 0,
    willItSnow: 0,
    chanceOfSnow: 0,
    visKm: 0,
  );
}
