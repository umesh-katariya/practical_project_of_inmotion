import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical_project/screens/fetch_weather/weather_page.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'screens/fetch_weather/weather_bloc.dart';


void main() async {
  startApp();
}

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  runApp(
    const App(),
  );
}

