import 'package:app_weather/data/weather_repository.dart';
import 'package:app_weather/locator.dart';
import 'package:app_weather/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum WeatherState {
  InitialWeatherState,
  WeatherLoadingState,
  WeatherLoadedState,
  WeatherErrorState
}

class WeatherViewModel with ChangeNotifier {
  WeatherState _state;
  //Statelerimiz için bir değişken tanımladık
  WeatherRepository _weatherRepository = locator<WeatherRepository>();
  //WEatherRepository Sınıfımızıa buradan veri göndereceğimiz ondan bir nesne ürettik
  Weather _getirilenWeather;
  //WEather Snıfında bir nesne geleceğiiçin Weather sınıfından bir nesne üretiyoruz.
  WeatherViewModel() {
    _getirilenWeather = Weather();
    //Başlangıçta boş bir weather ürettik.
    _state = WeatherState.InitialWeatherState;
    //Constructor içerisine tanımladığımız state değişkenine hemen initialState i başlangıçta atadık.
  }

  //getirilenWeatherın sadece getterını yazdık
  Weather get getirilenWeather => _getirilenWeather;
  //_state i get ve set yaptık
  WeatherState get state => _state;
  set state(WeatherState value) {
    _state = value;
    //Bir atama yaptığımız  için notifyListener koyuyorz.
    notifyListeners();
  }

  Future<Weather> havaDurumunuGetir(String sehirAdi) async {
    //Arayüzümüzden Veriyi alıp Repo muza iletmek için Bir fonksiyon tanımlıyoruz.
    try {
      state = WeatherState.WeatherLoadingState;
      //Durumumuzu loading e getiridk
      _getirilenWeather = await _weatherRepository.getWeather(sehirAdi);
      //REpository sınıfımıza gittik, oradaki getWeather methodunu çağırdık ve içerisine istediğimiz şehri gönderdik.
      state = WeatherState.WeatherLoadedState;
      //State i loaded a getiridk.
    } catch (e) {
      state = WeatherState.WeatherErrorState;
    }
    return _getirilenWeather;
    //En sonda getirilen Weather ı döndürdük.
  }

  Future<Weather> havaDurumunuGuncelle(String sehirAdi) async {
    //BURADA SAYFAYI YENİLEDİĞİNDE INDICATOR ÇIKMAMASI İÇİN LOADİNG STATE İNİ ÇIKARDIK VE ERROR KISMINI BOŞALTTIK
    //Arayüzümüzden Veriyi alıp Repo muza iletmek için Bir fonksiyon tanımlıyoruz.
    try {
      _getirilenWeather = await _weatherRepository.getWeather(sehirAdi);
      //REpository sınıfımıza gittik, oradaki getWeather methodunu çağırdık ve içerisine istediğimiz şehri gönderdik.
      state = WeatherState.WeatherLoadedState;
      //State i loaded a getiridk.
    } catch (e) {}
    return _getirilenWeather;
    //En sonda getirilen Weather ı döndürdük.
  }

  String getirilenWeatherKisaltma() {
    return _getirilenWeather.consolidatedWeather[0].weatherStateAbbr;
    //Getirilen Weatherın kısaltmasını uzun uzun uygulama içinde yazmamak için buna bir method yazdım.
  }
}
