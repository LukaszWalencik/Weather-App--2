// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'temp_settings_cubit.dart';

enum TempUnit { celsius, fahrenheit }

class TempSettingsState extends Equatable {
  final TempUnit tempUnit;
  TempSettingsState({
    this.tempUnit = TempUnit.celsius,
  });

  factory TempSettingsState.initial() {
    return TempSettingsState();
  }

  @override
  List<Object> get props => [tempUnit];

  @override
  bool get stringify => true;

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}
