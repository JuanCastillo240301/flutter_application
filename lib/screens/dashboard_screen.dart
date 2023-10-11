import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/screens/movie_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenido :)',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      drawer: createDrawer(),
    );
  }

  Widget createDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/giphy.gif'),
            ),
            accountName: Text(
              'JUAN',
              style: Theme.of(context).textTheme.headline6,
            ),
            accountEmail: Text(
              'JUAN@gmail.com',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset('assets/flcl1.jpg'),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('FLCL BD 4K',
                style: TextStyle(color: Colors.black, fontSize: 19.0)),
            subtitle: Text(
              'dvd series',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => movieDetails()),
              );
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset(
                'assets/icon4.png',
                height: 50,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'Popular Movies',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Lista de peliculas',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/popular');
              // Navigator.pushNamed(context, '/task');
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset('assets/ToDo.png'),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'TASK MANAGER',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Lista de tareas',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: () {
              //Navigator.pushNamed(context, '/popular');
              Navigator.pushNamed(context, '/task');
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset('assets/ToDo.png'),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'School Managment',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Lista de tareas',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: () {
              //Navigator.pushNamed(context, '/popular');
              Navigator.pushNamed(context, '/task');
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: DayNightSwitcher(
              isDarkModeEnabled: GlobalValues.flagTheme.value,
              onStateChanged: (isDarkModeEnabled) async {
                GlobalValues.flagTheme.value = isDarkModeEnabled;

                // Guarda el estado del tema en SharedPreferences
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setBool('isDarkModeEnabled', isDarkModeEnabled);
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 100.0, vertical: 200),
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                    Size(100.0, 30)), // Ancho máximo del botón
              ),
              onPressed: () async {
                // Limpiar el estado de "Recuérdame"
                SharedPreferences prefs = await SharedPreferences.getInstance();

                //await prefs.remove('rememberMe');

                // Redirigir al LoginPage
                Navigator.pushReplacementNamed(context, '/loginpage');
              },
              child: Text('Logout'),
            ),
          )
        ],
      ),
    );
  }
}
