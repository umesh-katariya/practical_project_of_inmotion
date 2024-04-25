import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/response_model.dart';
import '../models/weather_model.dart';
import '../utils/constants.dart';
import '../utils/url_utils.dart';

class WeatherRepository {
    final String apiKey = 'YOUR_API_KEY';

  Future<ResponseModel> fetchWeather(String cityName) async {

    final requestUrl = '${UrlUtils.getWeather}?q=${cityName.trim()}&appid=${Constants.weatherAPIKey}&units=metric';

    print("requestUrl-- $requestUrl");
    final response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ResponseModel(true,"",WeatherModel.fromJson(parsed));
    } else {
      final parsed = json.decode(response.body);
      return ResponseModel(false,parsed["message"]??'Failed to load weather',null);
      // throw Exception(parsed["message"]??'Failed to load weather');
    }
  }
}
