// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final double lat;
  final double lon;
  DirectGeocoding({
    required this.lat,
    required this.lon,
  });

  @override
  List<Object> get props => [lat, lon];

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];
    return DirectGeocoding(
      lat: data['lat'],
      lon: data['lon'],
    );
  }
}
