
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
  bool isLoggedIn() => _loggedIn;
  bool isLoading() => _loading;
  String getEmail() => _email;
  String getUserId() => _userId;
  String getNombre() => _nombre;
  SharedPreferences _prefs;
  bool _hasToken;
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

          _prefs.setBool('isLoggedIn', true);
          _prefs.setString('email', _email);
          _prefs.setString('userId', _userId);
          _prefs.setString('nombre', _nombre);
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
      _loggedIn = true;
      _loading = false;
      notifyListeners();
    }else{
     logout();
    }
  } 
  // Future<dynamic> _getToken(String _userId) async {
  //   var envelope = '''
  //     <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:gardewsdl">
  //       <soapenv:Header/>
  //       <soapenv:Body>
  //           <urn:wsmethod soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
  //             <case xsi:type="xsd:string">getColonoData</case>
  //             <value xsi:type="xsd:string">{"usuarioId":"'''+ _userId +'''"}</value>
  //           </urn:wsmethod>
  //       </soapenv:Body>
  //     </soapenv:Envelope>
  //     ''';
  //   http.Response response = await http.post (
  //     'https://gardeapp.com/ws/wsgarde.php',
  //     headers: {
  //       'Content-Type': 'text/xml; charset=utf-8'
  //     },
  //     body: envelope
  //   );
  //   var rawXmlResponse = response.body;
  //   xml.XmlDocument parsedXml = xml.parse (rawXmlResponse);
  //   final resp = json.decode(parsedXml.descendants.last.text);
    
  //   return resp;
  // }
  Future<Map<String, dynamic>> _handleLogin(String email, String _pass) async {
    String url = Variables.API_URL+'/api/login';
    String json = '{"email": "'+email+'", "password": "'+_pass.toString()+'"}';
    Map<String, dynamic> data = await http.post(url, json);
    return data;

  }
}