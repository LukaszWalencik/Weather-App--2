import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_event.dart';
part 'temp_settings_state.dart';

class TempSettingsBloc extends Bloc<TempSettingsEvent, TempSettingsState> {
  TempSettingsBloc() : super(TempSettingsInitial()) {
    on<TempSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
