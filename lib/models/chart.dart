import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart {
  final String title;
  final List<DataPoint> chartData;

  final Color? areaColor;
  final Color? borderColor;
  final double? borderWidth;
  final MarkerSettings? markerSettings;

  Chart({
    required this.title,
    required this.chartData,
    required this.areaColor,
    required this.borderColor,
    required this.borderWidth,
    required this.markerSettings,
  });
}

class DataPoint {
  final DateTime x;
  final double y;

  DataPoint(this.x, this.y);
}
