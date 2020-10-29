import 'package:app_weather/models/myTheme.dart';
import 'package:flutter/material.dart';

class MyThemeViewModel with ChangeNotifier {
  MyTheme _myTheme;

  MyThemeViewModel() {
    _myTheme = MyTheme(Colors.blue, ThemeData.light());
    //Bu nesne çağırıldığında ilk oluşturulacak renkleri yukarıda verdik. MyTheme Classımızdan çağırarak.
  }

  MyTheme get myTheme => _myTheme;
  //Mevcut değeri arayüzümüze almak için
  set myTheme(MyTheme value) {
    _myTheme = value;
    notifyListeners();
    //state i dinlemek için mutalaka set içerisine notifyListener koyuyoruz.
  }
  //Ara yüzümüzden değer atamak için.

  void temaDegistir(String havaDurumuKisaltmasi) {
    //Hava durumunda Hava durmu simgelerini çektiğimiz değişkeni buraya göndererek o an ki hava durumuna göre tema   rengi vereceğiz.

    MyTheme _geciciTema;
    //Switch içindeki durumları koymak için geçici bir Tema nesnei ürettik, en son bunu myTheme e göndereceğiz
    //Geçici nesne yerine myTeheme atsak, Swtich içerisinde doğruyu bulana kadar sürekli değişirdi.
    switch (havaDurumuKisaltmasi) {
      case "sr": //karlı
      case "sl": //sulu kar
      case "h": //dolu
      case "t": //fırtına
      case "hc": //çok bulutlu
        _geciciTema =
            MyTheme(Colors.grey, ThemeData(primaryColor: Colors.blueGrey));
        break;
      case "hr": //yoğun yağış
      case "lr": //hafif yağış
      case "s": //sağanak
        _geciciTema = MyTheme(
            Colors.indigo, ThemeData(primaryColor: Colors.indigoAccent));
        break;
      case "lc": //az bulut
      case "c": //açık güneş
        _geciciTema = MyTheme(
            Colors.yellow, ThemeData(primaryColor: Colors.orangeAccent));
        break;
    }
    myTheme = _geciciTema;
    //Geçici seçilen temayı ana Temamıza gönderdik.
  }
}
