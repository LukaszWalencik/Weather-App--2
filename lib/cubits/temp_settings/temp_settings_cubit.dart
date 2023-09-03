import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_state.dart';

class TempSettingsCubit extends Cubit<TempSettingsState> {
  TempSettingsCubit() : super(TempSettingsInitial());
}
