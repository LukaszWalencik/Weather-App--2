// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final Weather weather;
  final CustomError error;
  final WeatherStatus status;
  WeatherState({
    required this.weather,
    required this.error,
    required this.status,
  });
  factory WeatherState.initial() {
    return WeatherState(
        weather: Weather.initial(),
        error: CustomError(),
        status: WeatherStatus.initial);
  }
  @override
  List<Object> get props => [weather, error, status];

  @override
  bool get stringify => true;

  WeatherState copyWith({
    Weather? weather,
    CustomError? error,
    WeatherStatus? status,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
