import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/screens/movie_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class SchoolDashboardScreen extends StatefulWidget {
  const SchoolDashboardScreen({Key? key}) : super(key: key);

  @override
  State<SchoolDashboardScreen> createState() => _SchoolDashboardScreenState();
}

class _SchoolDashboardScreenState extends State<SchoolDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'School Management',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      drawer: createDrawer(),
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),
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
              child: Image.asset('assets/IconCarrera.png'),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('CARRERA',
                style: TextStyle(color: Colors.black, fontSize: 19.0)),
            subtitle: Text(
              'Administracion de Carreras',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/carrera');
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset(
                'assets/IconMaestro.png',
                height: 50,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'MAESTRO',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Administracion de Maestros',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/profesor');
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset('assets/IconHomeworks.png'),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'TAREA',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Adminitracion de Tareas',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/tarea');
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
                Navigator.pushNamed(context, '/dash');
              },
              child: Text('EXIT'),
            ),
          )
        ],
      ),
    );
  }
}
