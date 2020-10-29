import 'package:app_weather/data/weather_api_client.dart';
import 'package:app_weather/data/weather_repository.dart';
import 'package:app_weather/viewmodels/weather_view_model.dart';
import 'package:get_it/get_it.dart';

//BURADA HER DEFASINDA YENİ SİNGLETON OLUŞTURMAM KİÇİN SINGLETON KISMINI GETIT e BIRAKMAK İÇİN OLUŞTURDUĞUMUZ LOCATOR SINIFIMIZDIR

//Get it için oluşturduğumuz classtır
GetIt locator = GetIt.instance;
//bir adet getit sıfından değişken tanımladık
void setupLocator() {
  //void bir function tanımladık ve  her repository ye ulaşmak istediğinde artık singleton bir nesne üretecek.
  //Bu işi artık get it kütüphanesine bırakmış olduk
  locator.registerLazySingleton(() => WeatherRepository());
  //registerLazySingleton buraya bir istek atıldığınbda nesne oluşturur, direk registerSingleton deseydik; Uygulama başladığından oluşturacaktı.
  locator.registerLazySingleton(() => WeatherApiClient());
  //WeatherApiClient classı mıınz içinde de singleton kullanacağımız için, yukarıdaki gibi onun içinde bir singleton oluşturuyoruz.
  locator.registerFactory(() => WeatherViewModel());
  //ModelView sınıfımızıda locator a alıyoruz, bunun farkı her çağırıldığında yeni nesne üretilceği için factory Yaptık.
}
