import 'package:flutter/material.dart';

import 'app_theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'screens/fetch_weather/weather_bloc.dart';
import 'screens/fetch_weather/weather_page.dart';
import 'utils/app_strings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: AppStrings.appName,
      themeMode: ThemeMode.light,
      darkTheme: appTheme,
      debugShowCheckedModeBanner: false,
      // home: WeatherPage(weatherBloc),
      initialRoute: AppRoutes.weather,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
