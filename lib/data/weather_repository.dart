import 'package:app_weather/data/weather_api_client.dart';
import 'package:app_weather/models/weather.dart';
import '../locator.dart';

//BURADA; WEATHER CLIENTTE GETİRİLEN VERİLERİN ARAYÜZE GÖNDERİLMESİ VE ARAYÜZDEN İSTENEN ŞEHRİN CLİENTA AKTARILMA İŞLEMLERİ YAPILACAK
//PROVİDER KISMI BURADA YER ALACAK
class WeatherRepository {
  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();
  //WeatherApiClient ı burada kullanacağımız için locator a Singleton oluşturduktan sonra buraya gelip WeatherApiClienttan yukarıdaki şekilde
  //Bir nesne üretiyoruz.
  Future<Weather> getWeather(String sehir) async {
    final int sehirID = await weatherApiClient.getCityID(sehir);
    //WeatherClient sıfımıza gittik oradaki ilk işlem olan Şehri gönderdik ve Id sini almasını istedik
    return weatherApiClient.getHavaDurumu(sehirID);
    //WeatherApinin ilk methodu ile ID yi adlıktan sonra 2. Methduna gittik ve aldığımız ID yi gönderip Şehrin hava drumunu döndürmesini istedik.
  }
}
