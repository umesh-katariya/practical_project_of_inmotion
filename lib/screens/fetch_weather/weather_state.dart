import '../../models/weather_model.dart';

abstract class WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;

  WeatherLoaded({required this.weather});
}

class WeatherError extends WeatherState {
  final String? error;

  WeatherError({this.error});
}
