part of 'temp_settings_cubit.dart';

sealed class TempSettingsState extends Equatable {
  const TempSettingsState();

  @override
  List<Object> get props => [];
}

final class TempSettingsInitial extends TempSettingsState {}
