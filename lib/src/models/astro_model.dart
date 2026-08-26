import '../helpers/helper_functions.dart';

class AstroModel {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;
  final int isMoonUp;
  final int isSunUp;

  AstroModel({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  factory AstroModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return AstroModel.empty();
    }
    return AstroModel(
      sunrise: HelperFunctions.toStrings(json['sunrise']),
      sunset: HelperFunctions.toStrings(json['sunset']),
      moonrise: HelperFunctions.toStrings(json['moonrise']),
      moonset: HelperFunctions.toStrings(json['moonset']),
      moonPhase: HelperFunctions.toStrings(json['moon_phase']),
      moonIllumination: HelperFunctions.toInt(json['moon_illumination']),
      isMoonUp: HelperFunctions.toInt(json['is_moon_up']),
      isSunUp: HelperFunctions.toInt(json['is_sun_up']),
    );
  }

  factory AstroModel.empty() => AstroModel(
    sunrise: '',
    sunset: '',
    moonrise: '',
    moonset: '',
    moonPhase: '',
    moonIllumination: 0,
    isMoonUp: 0,
    isSunUp: 0,
  );
}
