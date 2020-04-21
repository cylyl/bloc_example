import 'package:bloc_example/date_utils.dart';
import 'package:bloc_example/forecast.dart';
import 'package:flutter/material.dart';

class ForecastList extends StatelessWidget {
  final List<Forecast> forecasts;
  final RefreshCallback refreshCallback;

  ForecastList({
    this.forecasts,
    this.refreshCallback
  });

  @override
  Widget build(BuildContext context) {
    ListView _buildList() {
      var rows = <Widget>[];
      forecasts.forEach((forecast) {
        rows.add( ForecastRow(forecast));
      });

      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: rows
      );
    }
    return RefreshIndicator(
      onRefresh: refreshCallback,
      child: _buildList(),
    );
  }
}

class ForecastRow extends StatelessWidget {
  Forecast _forecast;
  ForecastRow(this._forecast);

  @override
  Widget build(BuildContext context) {
    return Container(
     child : Text(_forecast.toString())
    );
  }
}