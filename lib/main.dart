import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/styles_app.dart';
import 'package:flutter_application_3/database/Noti.dart';
import 'package:flutter_application_3/provider/test_Provider.dart';
import 'package:flutter_application_3/routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
   tz.initializeTimeZones();
  // Inicializa SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Recupera el estado del tema
  bool isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;

  // Recupera el estado de "Recuérdame"
  bool rememberMe = prefs.getBool('rememberMe') ?? false;

  // Redirige a la pantalla correspondiente
  runApp(MyApp(
    isDarkModeEnabled: isDarkModeEnabled,
    rememberMe: rememberMe,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDarkModeEnabled;
  final bool rememberMe;

  const MyApp({required this.isDarkModeEnabled, required this.rememberMe});

  @override
  Widget build(BuildContext context) {
    GlobalValues.flagTheme.value = isDarkModeEnabled;

    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _) {
        return ChangeNotifierProvider(
          create: (context) => TestProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: rememberMe ? '/dash' : '/School',
            routes: getroutes(),
            theme: value
                ? stylesApp.darkTheme(context)
                : stylesApp.lightTheme(context),
          ),
        );
      },
    );
  }
}


// class home extends StatelessWidget {
//    home({super.key}) ;


// final data = [
//     CardPMovieData(
//       title: "Agrega a lista",
//       subtitle:
//           "Puedes crear listas con todas las peliculas para ver mas tarde.",
//       image: const AssetImage("assets/icon2.jpg"),
//       backgroundColor: Color.fromARGB(255, 83, 97, 163),
//       titleColor: const Color.fromARGB(255, 161, 29, 73),
//       subtitleColor: Color.fromARGB(255, 161, 29, 73),
//       background: LottieBuilder.asset("assets/a1.json")
//     ),    CardPMovieData(
//       title: "Mirar ahira",
//       subtitle: "Miles de peliculas a tu alcanza y a la palma de tu mano.",
//       image: const AssetImage("assets/icon3.jpg"),
//       backgroundColor: const Color.fromARGB(255, 234, 63, 63),
//       titleColor: const Color.fromARGB(255, 188, 139, 197),
//       subtitleColor: Color.fromARGB(255, 188, 139, 197),
//       background: LottieBuilder.asset("assets/a1.json")
//     ),    CardPMovieData(
//       title: "Realiza una Review",
//       subtitle: "Realiza reviews de las peliculas vistas y puntua con estrellas.",
//        image: const AssetImage("assets/icon4.png"),
//       backgroundColor: Color.fromARGB(255, 85, 85, 85),
//       titleColor: Color.fromARGB(227, 249, 226, 20),
//       subtitleColor: const Color.fromARGB(227, 249, 226, 20),
//       background: LottieBuilder.asset("assets/a1.json")
//     )];
    
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ConcentricPageView(
//        colors: data.map((e) => e.backgroundColor).toList(),
//       itemCount: data.length, // null = infinity
       
//        itemBuilder: (int index) {
//          return CardPlanet(data: data[index]);
//        },
//     ),
//     );
//   }
// }