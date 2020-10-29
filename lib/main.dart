import 'package:app_weather/locator.dart';
import 'package:app_weather/viewmodels/mytheme_view_model.dart';
import 'package:app_weather/viewmodels/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/weather_app.dart';

void main() {
  setupLocator();
  //SetupLocator ımızı mutlaka runAppten önce çağırmamız gereklidir.
  runApp(ChangeNotifierProvider(
      //Aslında Tema ve renk için MAterialApp i sarmamız gerekliydi ama başka widget a alıp sarmamız gerekecekti çünkü altında home kısmında diğer ChangeNotifier var
      //Oyüzden biz de bir üst ağaçtan yani runApp ten sardık.
      create: (context) => MyThemeViewModel(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeViewModel>(
      builder: (context, MyThemeViewModel myThemeViewModel, child) =>
          MaterialApp(
        //MyAppi ChangeNotifier ile sarıp mythemeViewModeli enjelte ettikten sonra, alt ağacı olan Material appi
        //bilgilendeirmek için Consumer sınıfı ile sarıyoruz.
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: myThemeViewModel.myTheme.tema,
        home: ChangeNotifierProvider(
            //ChangeNotifierProvider ile sarıyoruz ve buraya WeatherViewModeli veriyoruz, Çünkü arayüzün muhatap olacağı tek class o.
            //Bu calssıda locator a alıyoruz Ve oradan çağırıyoruz.
            create: (context) => locator<WeatherViewModel>(),
            //Locatordan ekledik.
            child: WeatherApp()),
      ),
    );
  }
}
