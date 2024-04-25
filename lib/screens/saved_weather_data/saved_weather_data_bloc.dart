import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../models/weather_model.dart';
import '../../sevice/weather_firestore.dart';
import '../../utils/app_strings.dart';
import 'saved_weather_data_state.dart';

class SavedWeatherDataBloc {
  final WeatherFirestore _weatherFirestore = WeatherFirestore();
  List<WeatherModel> _savedWeatherDataList = [];
  List<WeatherModel> _filteredWeatherData = [];

  final _weatherController = StreamController<SavedWeatherDataState>();

  Stream<SavedWeatherDataState> get weatherStream => _weatherController.stream;

  SavedWeatherDataBloc() {
    _weatherController.onListen = _fetchSavedWeatherData;
  }

  void _fetchSavedWeatherData() async{
    _weatherController.add(SavedWeatherDataLoading());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _weatherController.add(SavedWeatherDataError(error: AppStrings.noInternetConnection));
      return;
    }

    _weatherFirestore.fetchSavedWeatherData().then((savedWeatherDataList) {
      _savedWeatherDataList = savedWeatherDataList;
      _filteredWeatherData = _savedWeatherDataList;
      _weatherController.add(SavedWeatherDataLoaded(_savedWeatherDataList));
    }).catchError((error) {
      _weatherController.add(SavedWeatherDataError());
    });
  }

  void filterWeatherData(String searchText) {
    if (searchText.isEmpty) {
      _filteredWeatherData = _savedWeatherDataList;
    } else {
      _filteredWeatherData = _savedWeatherDataList
          .where((weather) =>
              (weather.name?.toLowerCase().contains(searchText.toLowerCase()) ??
                  false) ||
              (weather.temperature?.toString().toLowerCase().contains(searchText.toLowerCase()) ??
                  false) ||
              (weather.humidity?.toString().toLowerCase().contains(searchText.toLowerCase()) ??
                  false))
          .toList();
    }
    _weatherController.add(SavedWeatherDataLoaded(_filteredWeatherData));
  }

  void dispose() {
    _weatherController.close();
  }
}
