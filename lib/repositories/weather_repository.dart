// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app2/exceptions/weather_exception.dart';
import 'package:weather_app2/models/custom_error.dart';
import 'package:weather_app2/models/direct_geocoding.dart';
import 'package:weather_app2/models/weather.dart';
import 'package:weather_app2/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchDirectGeocoding(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);
      print('DirectGeocoding: $directGeocoding');
      final Weather weather =
          await weatherApiServices.getWeather(directGeocoding);

      print('Weather: $weather');

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errorMessage: e.message!);
    } catch (e) {
      throw CustomError(errorMessage: e.toString());
    }
  }
}
