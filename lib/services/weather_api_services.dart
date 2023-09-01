// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app2/constants/constants.dart';
import 'package:weather_app2/exceptions/weather_exception.dart';
import 'package:weather_app2/models/direct_geocoding.dart';
import 'package:weather_app2/models/weather.dart';
import 'package:weather_app2/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<DirectGeocoding> getDirectGeocoding(String city) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kApiHost,
        path: '/geo/1.0/direct',
        queryParameters: {
          'q': city,
          'limit': kLimit,
          'appid': dotenv.env['APPID']
        });
    try {
      final http.Response response = await httpClient.get(uri);
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      final responseBody = jsonDecode(response.body);
      if (responseBody == []) {
        throw WeatherException(message: 'Cannot get the location of $city');
      }
      final directGeocoding = DirectGeocoding.fromJson(responseBody);
      return directGeocoding;
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kApiHost,
        path: '/data/2.5/weather',
        queryParameters: {
          'lat': '${directGeocoding.lat}',
          'lon': '${directGeocoding.lon}',
          'units': kUnit,
          'appid': dotenv.env['APPID']
        });
    try {
      http.Response response = await httpClient.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      final weatherJson = jsonDecode(response.body);
      final Weather weather = Weather.fromJson(weatherJson);
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
