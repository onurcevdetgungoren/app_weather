import 'dart:ui';
import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  //Şehir seç sayfasında seçilen şehri Yazdırmak için buraya gönderiyoruz.
  final String secilenSehir;
  LocationWidget({@required this.secilenSehir});
  //@required eklediğimizde zorunlu parametre olacaktr ve mutlaka verilmesi gereklidir.
  @override
  Widget build(BuildContext context) {
    return Text(
      secilenSehir,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
