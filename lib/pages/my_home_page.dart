import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/cubits/weather/weather_cubit.dart';
import 'package:weather_app2/pages/search_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
              onPressed: () async {
                _city = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchPage()));
                print('City: $_city');
                if (_city != null) {
                  context.read<WeatherCubit>().fetchWeather(_city!);
                }
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: _showWeather(),
    );
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        if (state.status == WeatherStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: Text(state.weather.name),
        );
      },
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.error.errorMessage),
              );
            },
          );
        }
      },
    );
  }
}
