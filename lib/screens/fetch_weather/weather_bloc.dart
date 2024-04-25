import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practical_project/models/weather_model.dart';
import 'package:practical_project/repositories/weather_repository.dart';
import 'package:practical_project/utils/app_strings.dart';

import '../../models/response_model.dart';
import '../../sevice/weather_firestore.dart';
import '../../utils/loader_dialog.dart';
import 'weather_state.dart';

class WeatherBloc {
  final WeatherRepository weatherRepository;
  final WeatherFirestore _weatherFirestore = WeatherFirestore();


  final _weatherController = StreamController<WeatherState>();
  Stream<WeatherState> get weatherStream => _weatherController.stream;
  StreamSink<WeatherState> get weatherSink => _weatherController.sink;

  WeatherBloc() : weatherRepository = WeatherRepository() {
    _weatherController.onListen = _fetchInitialWeather;
  }

  void _fetchInitialWeather() {
    // fetchWeather("InitialCity");
  }

  void fetchWeather(String cityName) async {
    weatherSink.add(WeatherLoading());
    try {

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _weatherController.add(WeatherError(error: AppStrings.noInternetConnection));
        return;
      }

      ResponseModel responseModel = await weatherRepository.fetchWeather(cityName);
      if(responseModel.isSuccess) {
        weatherSink.add(WeatherLoaded(weather: responseModel.data));
      }else {
        weatherSink.add(WeatherError(error: responseModel.message));
      }
    } catch (e) {
      weatherSink.add(WeatherError(error: "$e"));
    }
  }

  void saveWeatherToFirestore(BuildContext context,WeatherModel weather) async{
    LoaderDialog.showLoader(context);
    _weatherFirestore.saveWeather(weather).then((_) {
      LoaderDialog.hideLoader(context);

      Fluttertoast.showToast(
          msg: AppStrings.weatherDataSavedSmg,
      );
    }).catchError((error) {
      LoaderDialog.hideLoader(context);
      Fluttertoast.showToast(
        msg: AppStrings.failedToSaveWeatherDataSmg,
      );
    });
  }

  void dispose() {
    _weatherController.close();
  }
}
