
import 'dart:async';
// import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'package:scorefan/classes/http_service.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:gardeapp/push_notifications.dart';

class LoginState with ChangeNotifier{
  
  bool _loggedIn = false;
  bool _loading = true;
  String _email='';
  String _userId='';
  String _nombre='';
  String _authtoken='';
  bool isLoggedIn() => _loggedIn;
  bool isLoading() => _loading;
  String getEmail() => _email;
  String getUserId() => _userId;
  String getNombre() => _nombre;
  String getAuthToken() => _authtoken;
  SharedPreferences _prefs;
  HttpService http = new HttpService();

  LoginState(){
    loginState();
  }
  Future<String> login(String email, String pass) async {
    String salida='';
    _loading = true;
    notifyListeners();
    final data =  await _handleLogin(email, pass);
    _loading = false;
    notifyListeners(); 
    if(data['ex']==null){
      if (data!=null) {
        Map<String, dynamic> obj = data;
        // print(obj);
        if(obj['error']=='0'){
          _loggedIn = true;
          _email = obj['user']['email'];
          _userId = obj['user']['id'].toString();
          _nombre = obj['user']['name'];
          _authtoken = obj['access_token'];
          _prefs.setBool('isLoggedIn', true);
          _prefs.setString('email', _email);
          _prefs.setString('userId', _userId);
          _prefs.setString('nombre', _nombre);
          _prefs.setString('authtoken', _authtoken);
          _loggedIn = true;
          notifyListeners();
          salida= '1';
        }else{
          salida= obj['message'];
        }
      }else{
        _loggedIn = false;
        notifyListeners();
      }
    }else{
      salida = data['ex'];
    }
    return salida;
  }

  void logout(){
    _prefs.clear();
    _loggedIn = false;
    _loading = false;
    notifyListeners();
  }
  void loginState() async {
    _prefs = await SharedPreferences.getInstance();
    if(_prefs.containsKey('isLoggedIn') ){
      _email=_prefs.getString('email');
      _userId=_prefs.getString('userId');
      _nombre=_prefs.getString('nombre');
      _authtoken=_prefs.getString('authtoken');
      _loggedIn = true;
      _loading = false;
      notifyListeners();
    }else{
     logout();
    }
  } 
  Future<Map<String, dynamic>> _handleLogin(String email, String _pass) async {
    String url = Variables.API_URL+'/api/login';
    String json = '{"email": "'+email+'", "password": "'+_pass.toString()+'"}';
    Map<String, dynamic> data = await http.post(url, json);
    return data;

  }
}