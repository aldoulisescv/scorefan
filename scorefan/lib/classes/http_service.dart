import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {

  Future<Map<String, dynamic>> post(String url, String json, [String token=''] ) async {
    String result;
    try {
      Map<String, String> _headers;
      if(token=='')
        _headers = {"Content-type": "application/json" }; 
      else
        _headers = {"Content-type": "application/json", "Authorization" :"Bearer "+token+""}; 
      http.Response response = await http.post(url, headers: _headers, body: json);
      // check the status code for the result
      String body = response.body;
      log(body.toString());
      Map<String, dynamic> obj = jsonDecode(body);
      return obj;
    } on SocketException catch(e){
        print(e);
      result = "Sin conexíon a internet o al servidor 😑";
    } on HttpException catch(e){
        print(e);
      result="No se encontró el documento 😱";
    } on FormatException catch(e){
        print(e);
      result="Respuesta en mal formato 👎";
    } on Exception catch(e){
        print(e);
      result="Otro tipo de Excepción 👎";
    }
    return jsonDecode('{"ex":"'+result+'"}');
  }
  Future<Map<String, dynamic>> get(String url, [String token='']) async {
    String result;
    try {
      Map<String, String> _headers;
      if(token=='')
        _headers = {"Content-type": "application/json" }; 
      else
        _headers = {"Content-type": "application/json", "Authorization" :"Bearer "+token+""}; 

      http.Response response = await http.get(url, headers: _headers);
      String body = response.body;
      Map<String, dynamic> obj = jsonDecode(body);
      // print(obj);
      return obj;
      } on SocketException catch(e){
        print(e);
      result = "Sin conexíon a internet o al servidor 😑";
    } on HttpException  catch(e){
        print(e);
      result="No se encontró el documento 😱";
    } on FormatException  catch(e){
        print(e);
      print(url);
      result="Respuesta en mal formato 👎";
    } on Exception  catch(e){
        print(e);
      result="Otro tipo de Excepción 👎";
    }
    return jsonDecode('{"ex":"'+result+'"}');
  }
}