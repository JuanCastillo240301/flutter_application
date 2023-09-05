import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

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
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage('https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMnM2OWVoaWlzYXI5azY5amt3aWphdDh6ajR1dWtkOTc0dHQwb2pydiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/BK1EfIsdkKZMY/giphy.gif'),
          ),
          accountName: Text('Rubensin'),
           accountEmail: Text('istorres@gmail.com')
          )
          ,ListTile(
            leading: Image.asset('assets/icon1.png'),
            trailing: Icon(Icons.chevron_right),
            title: Text('FruitApp'),
            subtitle: Text('Carrusel'), 
            onTap: (){},
          )
         // DayNightSwitcher(isDarkModeEnabled: isDarkModeEnabled, onStateChanged: onStateChanged)
      ],
    ),
  );
}
}