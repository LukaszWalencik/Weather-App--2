import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app2/models/custom_error.dart';
import 'package:weather_app2/models/weather.dart';
import 'package:weather_app2/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    print('State: $state');

    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));

      print('State: $state');
    } on CustomError catch (e) {
      emit(state.copyWith(status: WeatherStatus.error, error: e));

      print('State: $state');
    }
  }
}
