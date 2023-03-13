import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'transaction.dart';
import 'chart_series.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final List<ChartSeries> data = [];

  Chart(this.recentTransactions, {super.key});

  List get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      var newTx = ChartSeries(
          day: DateFormat.E().format(weekDay).substring(0, 1),
          amount: totalSum.toInt());
      return data.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactionValues;
    Iterable<ChartSeries> inReverse = data.reversed;
    List<ChartSeries> dataInReverse = inReverse.toList();
    List<charts.Series<ChartSeries, String>> series = [
      charts.Series(
          id: 'expense',
          data: dataInReverse,
          domainFn: (ChartSeries series, _) => series.day,
          measureFn: (ChartSeries series, _) => series.amount,
          colorFn: (_, _) => charts.MaterialPalette.blue.shadeDefault)
    ];
    return charts.BarChart(series, animate: true);
  }
}
