import 'dart:ffi';

import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';

class DashboardScreen extends StatefulWidget {
   const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
//bool isDarkModeEnabled =true;

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
          ),
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled){
            GlobalValues.flagTheme.value = isDarkModeEnabled;
  },
),
      ],
    ),
  );
}
}