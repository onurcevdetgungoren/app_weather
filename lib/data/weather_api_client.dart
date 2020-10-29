import 'package:app_weather/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//BU SAYFADA KULLANICIDAN ALDIĞIMIZ ŞEHİR BİLGİSİ İLE GİDİP ŞEHİRİN ID SİNİ ALACAĞIZ VE ONU WEATHER REPOSİTORY YE GÖNDERECEĞİZ.
class WeatherApiClient {
  static const baseUrl = "https://www.metaweather.com/";
  //Gideceğimiz sitenin urlsini yazdık
  final http.Client httpClient = http.Client();
  //Client yapmak için httpClient ı yazdık; artık bunu httpClient.get olarak kullanacağız.

  Future<int> getCityID(String sehirAdi) async {
    //ID yi almak için Id yi alacağımız Url ye gidiyoruz
    final sehirUrl = baseUrl + "/api/location/search/?query=" + sehirAdi;
    //Yukarıdaki siteden ID yi alacağız.
    final gelenCevap = await httpClient.get(sehirUrl);
    //Id yi alacağımız siteye http.get diyerek istek atıyoruz.
    if (gelenCevap.statusCode != 200) {
      throw Exception("Hata Alındı");
    }
    final gelenCevapJSON = (json.decode(gelenCevap.body)) as List;
    return gelenCevapJSON[0]["woeid"];
    //GelenCevabı json  a çevirdikten sonra gelen cevap zaten 1 elemanlı olacağı için
    //gelen cevabın 0. Elamanın woeid key inin value sini döndür diyeceğiz; Bu da Şehir ID si olacak.
  }

  Future<Weather> getHavaDurumu(int sehirID) async {
    //1.Future Fonksiyonda Şehirin Id sini aldık, Şimdi burada o Id ye göre hava durumunu alıp, Weather Modeline jsonDecode yapacağız.
    final havadurumuGelenCevap =
        await httpClient.get(baseUrl + "/api/location/$sehirID");
    //Bu kez hava durumunu almak için Şehir id sini göndererek oşehir için bir istk gönderiyoruz.
    if (havadurumuGelenCevap.statusCode != 200) {
      throw Exception("Hata Alındı");
    }

    final havaDurumuGelenCevapJSON = json.decode(havadurumuGelenCevap.body);
    return Weather.fromJson(havaDurumuGelenCevapJSON);
  }
}
