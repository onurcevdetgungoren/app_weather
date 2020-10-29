import 'dart:ui';

import 'package:app_weather/viewmodels/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HavaDurumuResimWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, WeatherViewModel _weatherViewModel, widget) =>
            Column(
              children: [
                Text(
                  _weatherViewModel
                          .getirilenWeather.consolidatedWeather.first.theTemp
                          .floor()
                          .toString() +
                      " °C",
                  //Buraya Dereceyi getirdik, .floor denmesinin sebebi küsüratları atmamız.
                  //first dememizin sebebi bugğnğ getirmemiz, bunda [0] da diyebiliridik first yerine
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                Image.network(
                  "https://www.metaweather.com/static/img/weather/png/" +
                      _weatherViewModel.getirilenWeather.consolidatedWeather
                          .first.weatherStateAbbr +
                      ".png",
                  width: 150,
                  height: 150,
                ),
                //Hava durumunun ısaltması icounu linkine verdik, bu kısaltmada weatherStateAbbr olarak geliyor Verilerle.
              ],
            ));
  }
}
