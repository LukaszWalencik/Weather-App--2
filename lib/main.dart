import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app2/cubits/weather/weather_cubit.dart';
import 'package:weather_app2/pages/my_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app2/services/weather_api_services.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          weatherApiServices: WeatherApiServices(httpClient: http.Client())),
      child: BlocProvider(
        create: (context) =>
            WeatherCubit(weatherRepository: context.read<WeatherRepository>()),
        child: MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
