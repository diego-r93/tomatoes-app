import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../data/dummy_gauges.dart';
import '../models/gauge.dart';
import '../components/gauge_item.dart';

class MyGauges extends StatefulWidget {
  const MyGauges({Key? key}) : super(key: key);

  @override
  State<MyGauges> createState() => _MyGaugesState();
}

class _MyGaugesState extends State<MyGauges> {
  Widget buildItem(Gauge gauge) {
    return Container(
      key: ValueKey(gauge),
      child: GaugeItem(gauge),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableGridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: gauges.map((element) => buildItem(element)).toList(),
      onReorder: (oldIndex, newIndex) {
        setState(
          () {
            final element = gauges.removeAt(oldIndex);
            gauges.insert(newIndex, element);
          },
        );
      },
    );
  }
}
