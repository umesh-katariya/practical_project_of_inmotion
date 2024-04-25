import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practical_project/models/weather_model.dart';

class WeatherFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveWeather(WeatherModel weather) async {
    try {
      Map<String, dynamic> weatherData = weather.toJson();
      weatherData['timestamp']= Timestamp.now();
      await _firestore.collection('weather').doc(weather.name).set(weatherData);
    } catch (error) {
      throw Exception('Failed to save weather data: $error');
    }
  }

  Future<List<WeatherModel>> fetchSavedWeatherData() async {
    try {
      final querySnapshot = await _firestore.collection('weather').get();
      final savedWeatherDataList = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return WeatherModel.fromJson(data);
      }).toList();
      return savedWeatherDataList;
    } catch (error) {
      throw Exception('Failed to fetch saved weather data: $error');
    }
  }

  Future<WeatherModel?> getWeatherByCity(String cityName) async {
    try {
      final querySnapshot = await _firestore.collection('weather').where('name', isEqualTo: cityName).get();
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data();
        return WeatherModel.fromJson(data);
      }
      return null; // Weather data for the city not found
    } catch (error) {
      throw Exception('Failed to get weather data: $error');
    }
  }


}
