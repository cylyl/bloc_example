import 'dart:async';

import 'package:bloc_example/forecast.dart';
import 'package:bloc_example/weather_api_client.dart';

class ForecastBloc {
  final _apiClient = WeatherAPIClient();

  ForecastBlocState _currentState;

  StreamSubscription<List<Forecast>> _fetchForecastSub;

  final _forecastController = StreamController<ForecastBlocState>.broadcast();
  Stream<ForecastBlocState> get forecastStream => _forecastController.stream;

  ForecastBloc() {
    _currentState = ForecastBlocState.empty();
  }

  ForecastBlocState getCurrentState() {
    return _currentState;
  }

  fetchForecastForCity(String city) {
    _fetchForecastSub?.cancel();

    _currentState.loading = true;
    _forecastController.add(_currentState);

    _apiClient.requestForecastForCity(city)
        .asStream()
        .listen((dynamic forecasts) {
          if (forecasts is List) {
            _currentState.forecasts = forecasts;
          }
          _currentState.loading = false;
          _forecastController.add(_currentState);
    });
  }
}

class ForecastBlocState {
  bool loading;
  List<Forecast> forecasts;

  ForecastBlocState(this.loading, this.forecasts);

  ForecastBlocState.empty() {
    loading = false;
    forecasts = null;
  }
}