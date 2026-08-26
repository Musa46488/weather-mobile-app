import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../repository/weather_repository.dart';

import '../../exceptions/api_exceptions.dart';
import '../../helpers/helper_functions.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository repository;

  WeatherCubit(this.repository) : super(const WeatherInitial());

  Future<void> loadWeather([String city = "Lahore"]) async {
    emit(const WeatherLoading());

    try {
      final weather = await repository.getForecast(city, 3);

      emit(WeatherLoaded(weather: weather, selectedCity: city));
    } on ApiException catch (e) {
      emit(WeatherError(e.message));
    } on DioException {
      emit(
        const WeatherError("Network error — Check your internet connection."),
      );
    } catch (e) {
      emit(WeatherError(HelperFunctions.mapErrorToMessage(e)));
    }
  }
}
