// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String descryption;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String name;
  final String country;
  final DateTime lastUpdate;
  Weather({
    required this.descryption,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.name,
    required this.country,
    required this.lastUpdate,
  });

  @override
  List<Object> get props {
    return [
      descryption,
      icon,
      temp,
      tempMin,
      tempMax,
      name,
      country,
      lastUpdate,
    ];
  }

  @override
  bool get stringify => true;

  Weather copyWith({
    String? descryption,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    String? name,
    String? country,
    DateTime? lastUpdate,
  }) {
    return Weather(
      descryption: descryption ?? this.descryption,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      name: name ?? this.name,
      country: country ?? this.country,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}
