import 'package:flutter/material.dart';

import '../data/dummy_charts.dart';
import '../models/chart.dart';
import '../components/chart_item.dart';

class MyCharts extends StatefulWidget {
  const MyCharts({Key? key}) : super(key: key);

  @override
  State<MyCharts> createState() => _MyChartsState();
}

class _MyChartsState extends State<MyCharts> {
  Widget buildItem(Chart chart) {
    return Container(
      key: ValueKey(chart),
      child: ChartItem(chart),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: charts.length,
      itemBuilder: (context, index) {
        return buildItem(charts[index]);
      },
    );
  }
}
