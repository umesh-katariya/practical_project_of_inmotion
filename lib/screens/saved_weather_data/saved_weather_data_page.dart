import 'package:flutter/material.dart';
import 'package:practical_project/models/weather_model.dart';
import 'package:practical_project/utils/app_strings.dart';

import '../../widgets/edit_text.dart';
import '../../widgets/text_view.dart';
import 'saved_weather_data_bloc.dart';
import 'saved_weather_data_state.dart';

class SavedWeatherDataPage extends StatefulWidget {
  @override
  _SavedWeatherDataPageState createState() => _SavedWeatherDataPageState();
}

class _SavedWeatherDataPageState extends State<SavedWeatherDataPage> {
  final SavedWeatherDataBloc _savedWeatherDataBloc = SavedWeatherDataBloc();

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _savedWeatherDataBloc.fetchSavedWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextView(
          AppStrings.savedWeatherData,
          fontSize: 18,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EditText(
              controller: _searchController,
              hint: AppStrings.searchHintText,
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                _savedWeatherDataBloc.filterWeatherData(value);
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<SavedWeatherDataState>(
              stream: _savedWeatherDataBloc.weatherStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final state = snapshot.data;
                  if (state is SavedWeatherDataLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SavedWeatherDataLoaded) {
                    return _buildWeatherList(state.savedWeatherDataList);
                  } else if (state is SavedWeatherDataError) {
                    return Center(
                        child: TextView(
                            state.error ?? AppStrings.fetchFeatherErrorMessage));
                  }
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherList(List<WeatherModel> savedWeatherDataList) {
    if(savedWeatherDataList.isEmpty){
      return const Center(
          child: TextView(AppStrings.noDataFound));
    }
    return ListView.builder(
      itemCount: savedWeatherDataList.length,
      itemBuilder: (context, index) {
        final savedWeatherData = savedWeatherDataList[index];
        return ListTile(
          title: TextView(savedWeatherData.name ?? ""),
          subtitle: TextView(
              '${AppStrings.temperature}: ${savedWeatherData.temperature}°C, ${AppStrings.humidity}: ${savedWeatherData.humidity}%'),
        );
      },
    );
  }

  @override
  void dispose() {
    _savedWeatherDataBloc.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
