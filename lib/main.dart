import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'pages/home_page.dart';
import 'pages/sensors_page.dart';
import 'pages/settings_page.dart';
import 'utils/app_routes.dart';
import 'utils/mongodb_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/.env");
  await MongoDatabase.connect();

  await Future.wait([]);

  runApp(const MyApp());
}

const _canvasColorDark = Color.fromRGBO(19, 19, 19, 1);
// const _canvasColorLight = Color.fromARGB(255, 255, 255, 255);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Greenhouse',
      theme: ThemeData(
        canvasColor: _canvasColorDark,
        fontFamily: 'Raleway',
        textTheme: ThemeData.dark().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primaryColorDark: Colors.black,
        ),
      ),
      routes: {
        AppRoutes.home: (ctx) => const HomePage(),
        AppRoutes.sensorDetail: (ctx) => const SensorsPage(),
        AppRoutes.settingsPage: (ctx) => const SettingsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
