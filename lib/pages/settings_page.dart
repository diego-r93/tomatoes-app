import 'package:flutter/material.dart';

import '../components/app_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Settings'),
      ),
    );
  }
}
