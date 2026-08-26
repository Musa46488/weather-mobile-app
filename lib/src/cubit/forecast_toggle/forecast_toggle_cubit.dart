import 'package:flutter_bloc/flutter_bloc.dart';

import 'forecast_toggle_state.dart';

class ForecastToggleCubit extends Cubit<ForecastToggleState> {
  ForecastToggleCubit() : super(const HourlyForecastState());

  void showHourly() {
    emit(const HourlyForecastState());
  }

  void showWeekly() {
    emit(const WeeklyForecastState());
  }
}
