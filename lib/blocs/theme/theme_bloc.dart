import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ChangeThemeEvent>(_changeTheme);
  }
  void _changeTheme(ChangeThemeEvent event, Emitter emit) {
    emit(state.copyWith(
        appTheme:
            state.appTheme == AppTheme.light ? AppTheme.dark : AppTheme.light));
  }
}
