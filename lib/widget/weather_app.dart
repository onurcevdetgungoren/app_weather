import 'dart:async';
import 'package:app_weather/viewmodels/mytheme_view_model.dart';
import 'package:app_weather/viewmodels/weather_view_model.dart';
import 'package:app_weather/widget/gecis_renkli_container.dart';
import 'package:app_weather/widget/sehir_sec.dart';
import 'package:flutter/material.dart';
import 'havadurumu_resim.dart';
import 'location_widget.dart';
import 'maxminsicaklikwidget.dart';
import 'songuncellenen_widget.dart';
import 'package:provider/provider.dart';

class WeatherApp extends StatelessWidget {
  String kullanicininSectigiSehir = "Ankara";
  WeatherViewModel _weatherViewModel;
  @override
  Widget build(BuildContext context) {
    /*Consumer(
      //Consumerı oluşturduk ve içerisine bize lazım olan WeatherView ı verdik. DİKKAT edelim maindeki gibi locatordan değil; urada direk verdik.
      builder: (context, WeatherViewModel _weatherViewModel, widget) =>*/
    _weatherViewModel = Provider.of<WeatherViewModel>(context);
    //Consumer yerine Yukarıdakimethodu koyduk bu kez de bunu denedik.İkiside aynı şey.
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                //Dönen değeri alabilmek için async bir fonksiyona çevirdik.
                //Dönen şehir değerini secilenSehir içerisine alacağız.
                kullanicininSectigiSehir = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SehirSecWidget()));
                _weatherViewModel.havaDurumunuGetir(kullanicininSectigiSehir);
              }),
        ],
      ),
      body: Center(
        //State durumlarına göre yönlendirilecek sayfaları yazdık.
        child: (_weatherViewModel.state == WeatherState.WeatherLoadedState)
            ? HavaDurumuGeldi()
            : (_weatherViewModel.state == WeatherState.WeatherLoadingState)
                ? havaDurumuGetiriliyor()
                : (_weatherViewModel.state == WeatherState.WeatherErrorState)
                    ? havaDurumuGetirHata()
                    : Text("Şehir Seçin"),
        //İnitial State te Şehir Seçin gelecek, yani başlangıç ekranıda bu olacak.
      ),
    );
  }

  havaDurumuGetiriliyor() {
    //Bu state de Zaten Center içindeyiz, direk Progress bar döndüreceğiz.
    return CircularProgressIndicator();
  }

  havaDurumuGetirHata() {
    //CEnter içindeyiz bu state olursa TExt Yazdıracağız
    Text("Hava Durumu getirilirken hata oluştu");
  }
}

class HavaDurumuGeldi extends StatefulWidget {
  @override
  _HavaDurumuGeldiState createState() => _HavaDurumuGeldiState();
}

class _HavaDurumuGeldiState extends State<HavaDurumuGeldi> {
  WeatherViewModel _weatherViewModel;
  Completer<void> _refreshIndicator;
  //RefreshIndicator için bu değişkeni tanımladık. Refsresh indicator sayfasının yenilenmesini sağlar.
  //Ayrı bir Widget açtığımız için burada tüm değişkenlerimizi tekrar tanımladık
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshIndicator = Completer<void>();
    print("initState Tetiklendi");
    //Uygulama her başladığında otomatik olarak sayfayı yenilemesi için yazdık.
    //AŞAĞIDAKİ KOD BUILD METHODU ÇALIŞTIĞINDA BİZE BİR CALLBACK VERMEYE YARAYAN BİR KODDUR
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var kisaltma =
          Provider.of<WeatherViewModel>(context).getirilenWeatherKisaltma();
      //İnitiliza işlemleri build içinde yapıldığı için burada tekrar Provider.of yazmak durumunda kaldık
      //Kısaltmai çin yazdığımız kodu burada çağırdık.
      print("Kısaltma Kodu : $kisaltma");
      Provider.of<MyThemeViewModel>(context).temaDegistir(kisaltma);
      //MythemeModelViewde yazdığımız temaDeğştir methoduna kısatlmayı gönderdik.
      //Tabbiki yine initiliaze ollmadığı için burada initiliaze yaptık
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Widget Build Tetiklendi");
    _refreshIndicator.complete();
    _refreshIndicator = Completer<void>();
    //Refresh indicator ın dönüp kalmaması için bitirip tekrar başlattık Buildden sonra.
    _weatherViewModel = Provider.of<WeatherViewModel>(context);
    //Ayrı bir class oluştuğunda tüm değişkenlerimize sınıflarını initiliaze ettik.
    String kullanicininSectigiSehir = _weatherViewModel.getirilenWeather.title;
    return GecisliArkaPlanContainer(
      //Hazırladığımız Container ile Aşağıdaki ağacı sarıyoruz.
      renk: Provider.of<MyThemeViewModel>(context).myTheme.renk,
      child: RefreshIndicator(
        //Sayfayı aşağı çekerek yenilemeye yarar, yukarda değşkenini tanımladık.
        onRefresh: () {
          _weatherViewModel.havaDurumunuGuncelle(kullanicininSectigiSehir);
          return _refreshIndicator.future;
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: LocationWidget(
                secilenSehir: kullanicininSectigiSehir,
                //Buraya Seçilen Şehri yazdırmak için gönderiyoruz.
              )),
              //Seçilen Şehri yazdıracağız
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: SonGuncellemeWidget()),
              //Sayfayı yenilediğimizde güncellenen saati falan yazdıracağız.
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: HavaDurumuResimWidget()),
              //Hava Durumu resmi
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: MaxMinSicaklikWidget()),
              //Hava Durumu resmi
            ),
          ],
        ),
      ),
    );
  }
}
