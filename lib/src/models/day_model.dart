import '../helpers/helper_functions.dart';
import 'air_quality_model.dart';
import 'condition_model.dart';

class DayModel {
  final double maxtempC;
  final double mintempC;
  final double avgtempC;
  final double maxwindKph;
  final double totalprecipMm;
  final double avghumidity;
  final ConditionModel condition;
  final double uv;
  final AirQualityModel airQuality;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final double avgvisKm;

  DayModel({
    required this.maxtempC,
    required this.mintempC,
    required this.avgtempC,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.avghumidity,
    required this.condition,
    required this.uv,
    required this.airQuality,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.avgvisKm,
  });

  factory DayModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return DayModel.empty();
    }
    return DayModel(
      maxtempC: HelperFunctions.toDouble(json['maxtemp_c']),
      mintempC: HelperFunctions.toDouble(json['mintemp_c']),
      avgtempC: HelperFunctions.toDouble(json['avgtemp_c']),
      maxwindKph: HelperFunctions.toDouble(json['maxwind_kph']),
      totalprecipMm: HelperFunctions.toDouble(json['totalprecip_mm']),
      avghumidity: HelperFunctions.toDouble(json['avghumidity']),
      condition: ConditionModel.fromJson(json['condition']),
      uv: HelperFunctions.toDouble(json['uv']),
      airQuality: AirQualityModel.fromJson(json['air_quality']),
      dailyWillItRain: HelperFunctions.toInt(json['daily_will_it_rain']),
      dailyChanceOfRain: HelperFunctions.toInt(json['daily_chance_of_rain']),
      dailyWillItSnow: HelperFunctions.toInt(json['daily_will_it_snow']),
      dailyChanceOfSnow: HelperFunctions.toInt(json['daily_chance_of_snow']),
      avgvisKm: HelperFunctions.toDouble(
        json['avgvis_km'] ?? json['avgvis_km'] ?? json['avgvis_km'],
      ),
    );
  }

  factory DayModel.empty() => DayModel(
    maxtempC: 0,
    mintempC: 0,
    avgtempC: 0,
    maxwindKph: 0,
    totalprecipMm: 0,
    avghumidity: 0,
    condition: ConditionModel.empty(),
    uv: 0,
    airQuality: AirQualityModel.empty(),
    dailyWillItRain: 0,
    dailyChanceOfRain: 0,
    dailyWillItSnow: 0,
    dailyChanceOfSnow: 0,
    avgvisKm: 0,
  );
}
