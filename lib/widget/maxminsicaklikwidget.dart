import 'dart:ui';
import 'package:app_weather/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MaxMinSicaklikWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(
      builder: (context, WeatherViewModel weatherViewModel, widget) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Maximum :" +
                weatherViewModel
                    .getirilenWeather.consolidatedWeather.first.maxTemp
                    .floor()
                    .toString() +
                "°C",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Minimum :" +
                weatherViewModel
                    .getirilenWeather.consolidatedWeather.first.minTemp
                    .floor()
                    .toString() +
                "°C",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
