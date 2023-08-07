import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../models/gauge.dart';

final List<Gauge> gauges = [
  Gauge(
    title: 'Temperature',
    minimum: 0,
    maximum: 45,
    range: [
      GaugeRange(
        startValue: 0,
        endValue: 45,
        startWidth: 5,
        endWidth: 5,
        gradient: SweepGradient(
          colors: rainbow.reversed.toList(),
        ),
      ),
    ],
    needlePointerValue: 30,
    rangePointerValue: 30,
    gaugeAnotation: '35ºC',
  ),
  Gauge(
    title: 'Humidity',
    minimum: 0,
    maximum: 100,
    range: [
      GaugeRange(
        startValue: 0,
        endValue: 100,
        startWidth: 5,
        endWidth: 5,
        gradient: const SweepGradient(
          colors: rainbow,
        ),
      ),
    ],
    needlePointerValue: 70,
    rangePointerValue: 70,
    gaugeAnotation: '70%',
  ),
  Gauge(
    title: 'PH',
    minimum: 0,
    maximum: 14,
    range: [
      GaugeRange(
        startValue: 0,
        endValue: 14,
        startWidth: 5,
        endWidth: 5,
        gradient: const SweepGradient(
          colors: rainbow,
        ),
      ),
    ],
    needlePointerValue: 6.2,
    rangePointerValue: 6.2,
    gaugeAnotation: '6.2',
  ),
  Gauge(
    title: 'Condutivity',
    minimum: 0,
    maximum: 1400,
    range: [
      GaugeRange(
        startValue: 0,
        endValue: 1400,
        startWidth: 5,
        endWidth: 5,
        gradient: SweepGradient(
          colors: rainbow.reversed.toList(),
        ),
      ),
    ],
    needlePointerValue: 900,
    rangePointerValue: 900,
    gaugeAnotation: '900µS/cm',
  ),
  Gauge(
    title: 'Water Temperature',
    minimum: 0,
    maximum: 45,
    range: [
      GaugeRange(
        startValue: 0,
        endValue: 45,
        startWidth: 5,
        endWidth: 5,
        gradient: SweepGradient(
          colors: rainbow.reversed.toList(),
        ),
      ),
    ],
    needlePointerValue: 25,
    rangePointerValue: 25,
    gaugeAnotation: '25ºC',
  ),
  Gauge(
    title: 'Soil Humidity 2',
    minimum: 0,
    maximum: 100,
    range: [
      GaugeRange(
        startValue: 0,
        endValue: 100,
        startWidth: 5,
        endWidth: 5,
        gradient: const SweepGradient(
          colors: rainbow,
        ),
      ),
    ],
    needlePointerValue: 70,
    rangePointerValue: 70,
    gaugeAnotation: '70%',
  ),
  Gauge(
    title: 'Soil Humidity 1',
    minimum: 0,
    maximum: 100,
    range: [
      GaugeRange(
        startValue: 0,
        endValue: 100,
        startWidth: 5,
        endWidth: 5,
        gradient: const SweepGradient(
          colors: rainbow,
        ),
      ),
    ],
    needlePointerValue: 70,
    rangePointerValue: 70,
    gaugeAnotation: '70%',
  ),
  Gauge(
    title: 'Soil Humidity 3',
    minimum: 0,
    maximum: 100,
    range: [
      GaugeRange(
        startValue: 0,
        endValue: 100,
        startWidth: 5,
        endWidth: 5,
        gradient: const SweepGradient(
          colors: rainbow,
        ),
      ),
    ],
    needlePointerValue: 70,
    rangePointerValue: 70,
    gaugeAnotation: '70%',
  ),
];

const List<Color> rainbow = [
  Color(0xFFF44336),
  Color(0xFFFF5722),
  Color(0xFFFF9800),
  Color(0xFFFFC107),
  Color(0xFFFFEB3B),
  Color(0xFFCDDC39),
  Color(0xFF8BC34A),
  Color(0xFF4CAF50),
  Color(0xFF009688),
  Color(0xFF00ACC1),
  Color(0xFF03A9F4),
  Color(0xFF2196F3),
  Color(0xFF3F51B5),
  Color(0xFF673AB7),
];
