import 'forecast_day_model.dart';

class ForecastModel {
  final List<ForecastDayModel> forecastday;

  ForecastModel({required this.forecastday});

  factory ForecastModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return ForecastModel(forecastday: []);
    }
    final list = json['forecastday'];
    if (list == null || list is! List) {
      return ForecastModel(forecastday: []);
    }
    return ForecastModel(
      forecastday: List<ForecastDayModel>.from(
        list.map((e) => ForecastDayModel.fromJson(e)),
      ),
    );
  }
}
