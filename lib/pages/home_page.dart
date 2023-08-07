import 'package:flutter/material.dart';

import '../components/app_drawer.dart';
import '../screens/gauges.dart';
import '../screens/timers.dart';
import '../screens/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _screens = [
    _Screen(
      title: 'Home',
      screen: const MyGauges(),
      appBarActions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.sync,
          ),
        ),
      ],
      fab: null,
    ),
    _Screen(
      title: 'Timers',
      screen: const MyTimers(),
      appBarActions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.sync,
          ),
        ),
      ],
      fab: null,
    ),
    _Screen(
      title: 'Charts',
      screen: const MyCharts(),
      appBarActions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.sync,
          ),
        ),
      ],
      fab: null,
      // fab: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.indigo,
      //   child: const Icon(Icons.add),
      // ),
    ),
  ];

  _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedIndex].title),
        backgroundColor: Colors.black54,
        centerTitle: true,
        actions: _screens[_selectedIndex].appBarActions,
      ),
      body: _screens[_selectedIndex].screen,
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black54,
        unselectedItemColor: Colors.grey[800],
        selectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.schedule,
            ),
            label: 'Timers',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.area_chart,
            ),
            label: 'Charts',
          ),
        ],
        onTap: _selectScreen,
      ),
      floatingActionButton: _screens[_selectedIndex].fab,
    );
  }
}

class _Screen {
  final String title;
  final Widget screen;
  final List<Widget>? appBarActions;
  final FloatingActionButton? fab;

  _Screen({
    required this.title,
    required this.screen,
    this.appBarActions,
    required this.fab,
  });
}
