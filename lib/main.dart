import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app2/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:weather_app2/blocs/theme/theme_bloc.dart';
import 'package:weather_app2/blocs/weather/weather_bloc.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(
                weatherRepository: context.read<WeatherRepository>()),
          ),
          BlocProvider<TempSettingsBloc>(
            create: (context) => TempSettingsBloc(),
          ),
          BlocProvider<ThemeBloc>(create: (context) => ThemeBloc())
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Weather App',
              debugShowCheckedModeBanner: false,
              theme: state.appTheme == AppTheme.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
              home: const MyHomePage(),
            );
          },
        ),
      ),
    );
  }
}
