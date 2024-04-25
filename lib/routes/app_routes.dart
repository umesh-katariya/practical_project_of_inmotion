import 'package:flutter/material.dart';

import '../screens/fetch_weather/weather_page.dart';
import '../screens/saved_weather_data/saved_weather_data_page.dart';

class AppRoutes {
  static const String weather = '/';
  static const String savedWeatherData = '/saved';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case weather:
        return MaterialPageRoute(builder: (_) => WeatherPage());
      case savedWeatherData:
        return MaterialPageRoute(builder: (_) => SavedWeatherDataPage());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }

  static void navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Found'),
      ),
      body: Center(
        child: Text('Page not found!'),
      ),
    );
  }
}
