import 'package:flutter/material.dart';
import '../components/app_drawer.dart';
import '../models/gauge.dart';

class SensorsPage extends StatelessWidget {
  const SensorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Gauge gauge = ModalRoute.of(context)!.settings.arguments as Gauge;

    return Scaffold(
      appBar: AppBar(
        title: Text(gauge.title),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
    );
  }
}
