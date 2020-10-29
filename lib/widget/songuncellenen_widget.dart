import 'dart:ui';
import 'package:app_weather/viewmodels/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SonGuncellemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, WeatherViewModel weatherView, widget) => Text(
        "Son Güncelleme: " +
            TimeOfDay.fromDateTime(weatherView.getirilenWeather.time)
                .format(context),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}
