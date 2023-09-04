import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:weather_app2/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:weather_app2/blocs/theme/theme_bloc.dart';
import 'package:weather_app2/blocs/weather/weather_bloc.dart';
import 'package:weather_app2/constants/constants.dart';
import 'package:weather_app2/pages/search_page.dart';
import 'package:weather_app2/pages/settings.dart';
import 'package:weather_app2/widgets/error_dialog.dart';

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
              _city = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SearchPage()));
              print('City: $_city');
              if (_city != null) {
                context
                    .read<WeatherBloc>()
                    .add(FetchWeatherEvent(city: _city!));
              }
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            ),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: _showWeather(),
    );
  }

  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsBloc>().state.tempUnit;
    if (tempUnit == TempUnit.celsius) {
      return temperature.toStringAsFixed(1) + '℃';
    } else {
      return ((temperature * 9 / 5) + 32).toStringAsFixed(1) + '℉';
    }
  }

  Widget showIcon(String icon) {
    if (context.watch<ThemeBloc>().state.appTheme == ThemeData.light()) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/loading_light_mode.gif',
        image: 'http://$kIconHost/img/wn/$icon@4x.png',
        width: 96,
        height: 96,
      );
    } else {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/loading_dark_mode.gif',
        image: 'http://$kIconHost/img/wn/$icon@4x.png',
        width: 96,
        height: 96,
      );
    }
  }

  Widget formatText(String descryption) {
    final formattedString = descryption.titleCase;
    return Text(
      formattedString,
      style: TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    );
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherBloc, WeatherState>(
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
        if (state.status == WeatherStatus.error && state.weather.name == '') {
          return Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Text(
              state.weather.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(state.weather.lastUpdate)
                      .format(context),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  '(${state.weather.country})',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showTemperature(state.weather.temp),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      showTemperature(state.weather.tempMax),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      showTemperature(state.weather.tempMin),
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                showIcon(state.weather.icon),
                Expanded(flex: 3, child: formatText(state.weather.description)),
                Spacer()
              ],
            )
          ],
        );
      },
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.error.errorMessage);
        }
      },
    );
  }
}
