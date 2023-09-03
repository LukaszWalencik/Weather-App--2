import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void toggleTheme() {
    emit(state.copyWith(
        appTheme:
            state.appTheme == AppTheme.light ? AppTheme.dark : AppTheme.light));
    print('Theme state $state');
  }
}
