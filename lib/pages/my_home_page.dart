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
      body: Center(
        child: Text('Weather'),
      ),
    );
  }
}
