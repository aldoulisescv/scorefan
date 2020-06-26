import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {

  Future<Map<String, dynamic>> post(String url, String json ) async {
    String result;
    try {

      Map<String, String> headers = {"Content-type": "application/json"};
      http.Response response = await http.post(url, headers: headers, body: json);
      // check the status code for the result
      String body = response.body;
      
      Map<String, dynamic> obj = jsonDecode(body);
      return obj;
    } on SocketException {
      result = "Sin conexíon a internet o al servidor 😑";
    } on HttpException {
      result="No se encontró el documento 😱";
    } on FormatException {
      result="Respuesta en mal formato 👎";
    } on Exception {
      result="Otro tipo de Excepción 👎";
    }
    return jsonDecode('{"ex":"'+result+'"}');
  }
  Future<Map<String, dynamic>> get(String url ) async {
    String result;
    try {
      http.Response response = await http.get(url);
      String body = response.body;
      Map<String, dynamic> obj = jsonDecode(body);
      return obj;
      } on SocketException {
      result = "Sin conexíon a internet o al servidor 😑";
    } on HttpException {
      result="No se encontró el documento 😱";
    } on FormatException {
      result="Respuesta en mal formato 👎";
    } on Exception {
      result="Otro tipo de Excepción 👎";
    }
    return jsonDecode('{"ex":"'+result+'"}');
  }
}