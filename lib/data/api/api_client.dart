// Clase para conectarse con la api y acceder a la Base de Datos (de momento local, en un futuro remoto).

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_app/uitls/app_constants.dart';

class ApiClient extends GetConnect  implements GetxService{

  /*
  Tres variables.
  token --> el token por defecto es DBToken, es una variable late (se inicializa después de ser declarada)
  appBaseUrl --> la url es "http://10.0.2.2:8000"
  _mainHeaders --> mapa para guardar los datos localmente

  Estas variables son proporcionadas por la clase AppConstants del directorio utils.
  La ip es 10.0.2.2 porque la aplicación se está ejecutando en el emulador de Android Studio.
  10.0.2.2 en el emulador es equivalente a 127.0.0.1 en el equipo.
   */

  late String token;
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;

  /*
  Tiene un timeout (periodo de espera) de máximo 30 segundos.
  Un ejemplo de uri sería: "http://10.0.2.2:8000/api/v1/products/popular" (Accede a los productos populares).
  Si devuelve un 0 significa que NO ha habido errores.
  Si devuelve un 1 significa que SÍ ha habido errores.
   */

  ApiClient({required this.sharedPreferences, required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
   // timeout = Duration(seconds: 5);
    token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  void updateHeader(String token) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, String? contentType,
    Map<String, String>? headers, Function(dynamic)? decoder,
  }) async {
    try {

      Response response = await get(
        uri,
        contentType: contentType,
        query: query,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', //carrier
        },
        decoder: decoder,

      );
      response = handleResponse(response);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body,) async {
    try {
      Response response = await post(
        uri, body,
       // query: query,
       // contentType: contentType,
        headers:  _mainHeaders,

      );
      response = handleResponse(response);
      if(Foundation.kDebugMode) {
        log('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    }catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(Response response) {
    Response _response = response;
    if(_response.hasError && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: "Error");

      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);

      }
    }else if(_response.hasError && _response.body == null) {
      _response = Response(statusCode: 0, statusText: 'Connection to API server failed due to internet connection');
    }
    return _response;
  }
}