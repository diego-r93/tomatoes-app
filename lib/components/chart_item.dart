import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chart.dart';

class ChartItem extends StatelessWidget {
  const ChartItem(this.chart, {super.key});

  final Chart chart;

  List<ChartSeries<DataPoint, DateTime>> _getSeries() {
    return [
      AreaSeries<DataPoint, DateTime>(
        color: chart.areaColor,
        borderColor: chart.borderColor,
        borderWidth: chart.borderWidth,
        dataSource:
            chart.chartData.map((data) => DataPoint(data.x, data.y)).toList(),
        xValueMapper: (DataPoint data, _) => data.x,
        yValueMapper: (DataPoint data, _) => data.y,
        markerSettings: chart.markerSettings,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 29, 27, 28),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                title: ChartTitle(
                  text: chart.title,
                ),
                primaryXAxis: DateTimeAxis(),
                series: _getSeries(),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  header: '',
                  canShowMarker: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
