import 'package:practical_project/models/weather_model.dart';

abstract class SavedWeatherDataState {}

class SavedWeatherDataLoading extends SavedWeatherDataState {}

class SavedWeatherDataLoaded extends SavedWeatherDataState {
  final List<WeatherModel> savedWeatherDataList;

  SavedWeatherDataLoaded(this.savedWeatherDataList);
}

class SavedWeatherDataError extends SavedWeatherDataState {
  final String? error;

  SavedWeatherDataError({this.error});
}
