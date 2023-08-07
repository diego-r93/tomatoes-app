import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../models/gauge.dart';
import '../utils/app_routes.dart';

class GaugeItem extends StatelessWidget {
  const GaugeItem(this.gauge, {Key? key}) : super(key: key);

  final Gauge gauge;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 15,
      color: const Color.fromARGB(255, 29, 27, 28),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: InkWell(
        splashColor: const Color.fromARGB(255, 29, 27, 28),
        onTap: () => Navigator.of(context).pushNamed(
          AppRoutes.sensorDetail,
          arguments: gauge,
        ),
        child: SfRadialGauge(
          title: GaugeTitle(
            text: gauge.title,
            textStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          axes: <RadialAxis>[
            RadialAxis(
              showLabels: false,
              showTicks: false,
              showAxisLine: false,
              minimum: gauge.minimum,
              maximum: gauge.maximum,
              ranges: gauge.range,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: gauge.needlePointerValue,
                  needleStartWidth: 1,
                  needleEndWidth: 5,
                  knobStyle: const KnobStyle(
                    knobRadius: 0.05,
                    borderColor: Colors.black,
                    borderWidth: 0.02,
                    color: Colors.white,
                  ),
                  needleColor: Colors.white,
                ),
                RangePointer(
                    value: gauge.rangePointerValue,
                    color: gauge.getRangePointerColor(),
                    pointerOffset: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    width: 0.25),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Text(
                      gauge.gaugeAnotation,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    angle: 90,
                    positionFactor: 0.5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
