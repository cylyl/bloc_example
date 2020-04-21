import 'date_utils.dart';

class Forecast {
  double temperatures;
  DateTime times;

  Forecast.fromJson(Map<String, dynamic> json) {
    this.temperatures =  json['main']['temp'].toDouble();
    var timestamp = json['dt'] as int;
    this.times = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  @override
  String toString() {
    return DateUtils.formattedDate(times)+ " =  " + temperatures.toString() + ' C';
  }
}