import 'package:flutter/material.dart';

class Variables {

  static const TRANSPARENTE =  Color(0x00FFFFFF);
  static const BLANCO =  Color(0xFFFFFFFF);
  static const GRIS =  Color(0xFFE6E6E6);
  static const GRISOSCURO =  Color(0xFFE6E6E6);
  static const AZULCYAN =  Color(0xFF00FFFF);
  static const AZULCLARO =  Color(0xFF29ABE2);
  static const AZULFACEBOOK = Color(0xFF365aa0);
  static const AZULLOGO = Color(0xFF364C61);
  static const AZULOSCURO =  Color(0xFF142A46);
  static const ROJO =  Color(0xFFFB1218);
  
  double width(double _width, double valor){
    var result = _width * (valor/100);
    var res =  result.toDouble();
    return res;
  }
  double heigth(double _heigth, double valor){
    var result = _heigth * (valor/100);
    var res =  result.toDouble();
    return res;
  }
}