import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/cubits/temp_settings/temp_settings_cubit.dart';
import 'package:weather_app2/cubits/theme/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('Temperature Unit'),
              subtitle: Text('Celcius/Fahrenheit (Default: Celsius)'),
              trailing: Switch(
                  value: context.watch<TempSettingsCubit>().state.tempUnit ==
                      TempUnit.celsius,
                  onChanged: (_) {
                    context.read<TempSettingsCubit>().toggleTempUnit();
                  }),
            ),
            ListTile(
              title: Text('Theme mode'),
              subtitle: Text('Light/Dark (Default: Light)'),
              trailing: Switch(
                  value: context.watch<ThemeCubit>().state.appTheme ==
                      AppTheme.light,
                  onChanged: (_) {
                    context.read<ThemeCubit>().toggleTheme();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
