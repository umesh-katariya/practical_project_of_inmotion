import 'package:flutter/material.dart';
import 'package:practical_project/screens/fetch_weather/weather_bloc.dart';
import 'package:practical_project/utils/app_strings.dart';
import 'package:practical_project/utils/extenstion/sizedbox_extenstion.dart';
import 'package:practical_project/utils/validator.dart';

import '../../routes/app_routes.dart';
import '../../widgets/edit_text.dart';
import '../../widgets/raised_button.dart';
import '../../widgets/text_view.dart';
import 'weather_state.dart';

class WeatherPage extends StatefulWidget {

  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherBloc weatherBloc = WeatherBloc();
  final _formKey = GlobalKey<FormState>();
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body:  Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: EditText(
                  controller: cityController,
                  hint: AppStrings.enterCityName,
                  validator: Validator.cityNameValidator,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppRaisedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        weatherBloc.fetchWeather(cityController.text);
                      }
                    },
                    title: AppStrings.getWeather,
                    borderRadius: 100,
                  ),
                  AppRaisedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      AppRoutes.navigateTo(context, AppRoutes.savedWeatherData);
                    },
                    title: AppStrings.viewSaved,
                    borderRadius: 100,
                  ),
                ],
              ),
              20.height,
              StreamBuilder<WeatherState>(
                stream: weatherBloc.weatherStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final state = snapshot.data;
                    if (state is WeatherLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is WeatherLoaded) {
                      final weather = state.weather;
                      return Column(
                        children: [
                          TextView('${AppStrings.temperature}: ${weather.temperature}°C'),
                          TextView('${AppStrings.weather}: ${weather.weatherCondition}'),
                          10.height,
                          ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                                weatherBloc.saveWeatherToFirestore(context,state.weather);
                            },
                            child: const Text(AppStrings.saveToFirestore),
                          ),
                        ],
                      );
                    } else if (state is WeatherError) {
                      return Text(state.error??AppStrings.fetchFeatherErrorMessage);
                    }
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    weatherBloc.dispose();
    super.dispose();
  }
}
