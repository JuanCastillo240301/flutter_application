import 'package:concentric_transition/page_view.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/screens/card_movies.dart';
import 'package:flutter_application_3/screens/movie_details.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final data = [
      CardPMovieData(
          title: "Agrega a lista",
          subtitle:
              "Puedes crear listas con todas las peliculas para ver mas tarde.",
          image: const AssetImage("assets/icon2.jpg"),
          backgroundColor: Color.fromARGB(255, 83, 97, 163),
          titleColor: const Color.fromARGB(255, 161, 29, 73),
          subtitleColor: Color.fromARGB(255, 161, 29, 73),
          background: LottieBuilder.asset("assets/a1.json")),
      CardPMovieData(
          title: "Mirar ahira",
          subtitle: "Miles de peliculas a tu alcanza y a la palma de tu mano.",
          image: const AssetImage("assets/icon3.jpg"),
          backgroundColor: const Color.fromARGB(255, 234, 63, 63),
          titleColor: const Color.fromARGB(255, 188, 139, 197),
          subtitleColor: Color.fromARGB(255, 188, 139, 197),
          background: LottieBuilder.asset("assets/a1.json")),
      CardPMovieData(
          title: "Realiza una Review",
          subtitle:
              "Realiza reviews de las peliculas vistas y puntua con estrellas.",
          image: const AssetImage("assets/icon4.png"),
          backgroundColor: Color.fromARGB(255, 85, 85, 85),
          titleColor: Color.fromARGB(227, 249, 226, 20),
          subtitleColor: const Color.fromARGB(227, 249, 226, 20),
          background: LottieBuilder.asset("assets/a1.json"))
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenido :)',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      drawer: createDrawer(),
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length, // null = infinity

        itemBuilder: (int index) {
          return CardPlanet(data: data[index]);
        },
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
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset(
                'assets/favs.png',
                height: 50,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'Favs Movies',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Lista de peliculas',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/Favs');
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
              'School Management',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Lista de tareas',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/School');
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
              'Provider',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Provider',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/testP');
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
