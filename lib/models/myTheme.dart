//counter uygulamasında sadece counter değişkenini encapsulation yapmış ve repositoryimize almıştık, Bu uygulamada ise
//Weather modelimizi kontrol eden bir WeatherViewModel adında sınıf oluşturduk.
//Şimdi ise; Hem MAterial Color Hemde ThemeDataColor diye 2 adet veriiyi içeren bir sınıf oluşturacağız.

import 'package:flutter/material.dart';

class MyTheme {
  MaterialColor _renk;
  ThemeData _tema;

  MaterialColor get renk => _renk;
  set renk(MaterialColor value) {
    _renk = value;
  }

  ThemeData get tema => _tema;
  set tema(ThemeData value) {
    _tema = value;
  }

  MyTheme(this._renk, this._tema);
}
