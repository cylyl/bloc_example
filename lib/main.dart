import 'dart:async';

import 'package:bloc_example/forecast_bloc.dart';
import 'package:bloc_example/forecast_bloc_provider.dart';
import 'package:bloc_example/forecast_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Weather in Hamburg')),
        body: ForecastBlocProvider(
          bloc: ForecastBloc(),
          child: WeatherListScreen(
          ),
        ),
      ),
    );
  }
}

class WeatherListScreen extends StatelessWidget {
  WeatherListScreen({Key key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    ForecastBloc bloc = ForecastBlocProvider.of(context).bloc;
    bloc.fetchForecastForCity('Hamburg');

    return StreamBuilder<ForecastBlocState>(
        initialData: bloc.getCurrentState(),
        stream: bloc.forecastStream,
        builder: (BuildContext context,
            AsyncSnapshot<ForecastBlocState> snapshot) {
          if (snapshot.data.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ForecastList(
            forecasts: snapshot.data.forecasts,
            refreshCallback: () async {
              bloc.fetchForecastForCity('Hamburg');
              await bloc.forecastStream.first;
            },
          );
        }
    );
  }
}
