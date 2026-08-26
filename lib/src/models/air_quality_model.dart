import '../helpers/helper_functions.dart';

class AirQualityModel {
  final double co;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final int usEpaIndex;
  final int gbDefraIndex;

  AirQualityModel({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  factory AirQualityModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return AirQualityModel.empty();
    }
    return AirQualityModel(
      co: HelperFunctions.toDouble(json['co']),
      no2: HelperFunctions.toDouble(json['no2']),
      o3: HelperFunctions.toDouble(json['o3']),
      so2: HelperFunctions.toDouble(json['so2']),
      pm2_5: HelperFunctions.toDouble(json['pm2_5']),
      pm10: HelperFunctions.toDouble(json['pm10']),
      usEpaIndex: HelperFunctions.toInt(json['us-epa-index']),
      gbDefraIndex: HelperFunctions.toInt(json['gb-defra-index']),
    );
  }

  factory AirQualityModel.empty() => AirQualityModel(
    co: 0,
    no2: 0,
    o3: 0,
    so2: 0,
    pm2_5: 0,
    pm10: 0,
    usEpaIndex: 0,
    gbDefraIndex: 0,
  );
}
