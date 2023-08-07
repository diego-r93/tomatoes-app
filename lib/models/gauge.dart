import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Gauge {
  final String title;
  final double minimum, maximum;
  final List<GaugeRange>? range;
  final double needlePointerValue;
  final double rangePointerValue;
  final String gaugeAnotation;

  Color? rangePointerColor;

  Color? getRangePointerColor() {
    for (var indice in range!.toList()) {
      if (rangePointerValue < indice.endValue) {
        return indice.color ?? Colors.indigo[400];
      }
    }
    return Colors.indigo[400];
  }

  Gauge({
    required this.title,
    required this.minimum,
    required this.maximum,
    required this.range,
    required this.rangePointerValue,
    required this.needlePointerValue,
    required this.gaugeAnotation,
  });
}
