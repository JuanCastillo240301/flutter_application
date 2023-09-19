
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/routes.dart';
import 'package:flutter_application_3/screens/login_screen.dart';
import 'package:flutter_application_3/screens/movie_details.dart';
import 'package:flutter_application_3/assets/styles_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          accountName: Text('JUAN'),
           accountEmail: Text('JUAN@gmail.com')
          )
          ,ListTile(
            leading: Image.asset('assets/flcl1.jpg'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('FLCL BD 4K'),
            subtitle: const Text('ANIME SERIES'), 
            onTap: (){
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  movieDetails()),
  );
            },
          ),
          ListTile(
            leading: Image.asset('assets/flcl2.jpg'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('FLCL BD 4K'),
            subtitle: const Text('ANIME SERIES'), 
            onTap: (){
              Navigator.pushNamed(context, '/task');
            },
          ),
          DayNightSwitcher(
          isDarkModeEnabled: GlobalValues.flagTheme.value,
          onStateChanged: (isDarkModeEnabled) async {
            GlobalValues.flagTheme.value = isDarkModeEnabled;

            // Guarda el estado del tema en SharedPreferences
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isDarkModeEnabled', isDarkModeEnabled);
          },
        ),
         ElevatedButton(
              onPressed: () async {
                // Limpiar el estado de "Recuérdame"
                SharedPreferences prefs = await SharedPreferences.getInstance();
                
                //await prefs.remove('rememberMe');

                // Redirigir al LoginPage
                Navigator.pushReplacementNamed(context, '/loginpage');
              },
              child: Text('Logout'),
            )
      ],
    ),
  );
}
}