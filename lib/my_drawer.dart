import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Accueil'),
            onTap: () => Navigator.of(context).pushNamed('/'),
          ),
          ListTile(
            title: const Text('Plats'),
            onTap: () => Navigator.of(context).pushNamed('/meals'),
          ),
          ListTile(
            title: const Text('API'),
            onTap: () => Navigator.of(context).pushNamed('/api'),
          )
        ],
      ),
    );
  }
}
