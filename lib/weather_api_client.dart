import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc_example/forecast.dart';

class WeatherAPIClient {
  final _apiKey = 'dd4a9320bbd6adc3052fae784f1040b9';
  final _baseUrl = 'http://api.openweathermap.org/data/2.5';


  Future<Forecast> requestForecastForCity(String city) async {
    final forecastRoute = '/forecast?appid=$_apiKey&units=metric&q=$city,de';
    final url = _baseUrl + forecastRoute;
    http.Response res = await http.post(url);
    if (res.statusCode == 200) {
      String rawResponse = res.body;
      Map<String, dynamic> json = JsonCodec().decode(rawResponse);
      return Forecast.fromJson(json);
    } else {
      throw Exception();
    }
  }
}