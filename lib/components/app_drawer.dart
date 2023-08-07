import 'package:flutter/material.dart';

import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      backgroundColor: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('Diego Rodrigues'),
            accountEmail: const Text('diegorodrigues-5@hotmail.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(color: Colors.indigo.shade800),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        AppRoutes.home,
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: const Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Add Items',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: const Icon(
                      Icons.add_to_photos,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.settingsPage,
              );
            },
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
