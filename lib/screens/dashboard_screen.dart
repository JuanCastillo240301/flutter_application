import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido :)'),
      ),
drawer: createDrawer(),
    );
  }

Widget createDrawer(){
  return Drawer(
    child: ListView(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/giphy.gif'),
          ),
          accountName: Text('Rubensin'),
           accountEmail: Text('istorres@gmail.com')
          )
          ,ListTile(
            leading: Image.asset('assets/icon1.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('FruitApp'),
            subtitle: const Text('Carrusel'), 
            onTap: (){},
          )
         // DayNightSwitcher(isDarkModeEnabled: isDarkModeEnabled, onStateChanged: onStateChanged)
      ],
    ),
  );
}
}