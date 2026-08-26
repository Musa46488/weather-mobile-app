import '../helpers/helper_functions.dart';
import 'astro_model.dart';
import 'day_model.dart';
import 'hour_model.dart';

class ForecastDayModel {
  final String date;
  final int dateEpoch;
  final DayModel day;
  final AstroModel astro;
  final List<HourModel> hour;

  ForecastDayModel({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDayModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return ForecastDayModel(
        date: '',
        dateEpoch: 0,
        day: DayModel.empty(),
        astro: AstroModel.empty(),
        hour: [],
      );
    }
    final hourList = json['hour'];
    return ForecastDayModel(
      date: HelperFunctions.toStrings(json['date']),
      dateEpoch: HelperFunctions.toInt(json['date_epoch']),
      day: DayModel.fromJson(json['day']),
      astro: AstroModel.fromJson(json['astro']),
      hour: (hourList is List)
          ? List<HourModel>.from(hourList.map((e) => HourModel.fromJson(e)))
          : <HourModel>[],
    );
  }
}
