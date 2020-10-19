import 'dart:convert';
import 'dart:io';
import 'package:flutter_news_app/model/articles.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<Articles> getData() async {
    var responseJson;
    try {
      final response = await http.get(
          "http://newsapi.org/v2/everything?q=bitcoin&from=2020-9-20&sortBy=publishedAt&apiKey=4b0e2f99261745bdaa22d64a10a2a794",
          headers: {
            "Accept": "application/json",
          });
      responseJson = _response(response);
    } on SocketException {
      throw new Exception('No Internet Connection');
    }
    return Articles.fromJson(responseJson);
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw new Exception('Bad request');
      case 401:
      case 403:
      case 500:

      default:
        throw new Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
