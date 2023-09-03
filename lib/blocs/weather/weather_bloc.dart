// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app2/models/custom_error.dart';
import 'package:weather_app2/models/weather.dart';
import 'package:weather_app2/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({
    required this.weatherRepository,
  }) : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }
  Future<void> _fetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final Weather weather = await weatherRepository.fetchWeather(event.city);
      emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));
    } on CustomError catch (e) {
      emit(state.copyWith(status: WeatherStatus.error, error: e));
    }
  }
}
