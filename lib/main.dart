import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/styles_app.dart';
import 'package:flutter_application_3/routes.dart';
import 'package:flutter_application_3/screens/card_movies.dart';
import 'package:flutter_application_3/screens/login_screen.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _){
        return MaterialApp(
          home: const LoginScreen(),
          //home: const home(),
          routes: 
            getroutes()
          ,theme:  value ?
                    stylesApp.darkTheme(context):
                    stylesApp.lightTheme(context)
                    
        );
      }
    );
  }
}

class home extends StatelessWidget {
   home({super.key}) ;


final data = [
    CardPMovieData(
      title: "Agrega a lista",
      subtitle:
          "Puedes crear listas con todas las peliculas para ver mas tarde.",
      image: const AssetImage("assets/icon2.jpg"),
      backgroundColor: Color.fromARGB(255, 83, 97, 163),
      titleColor: const Color.fromARGB(255, 161, 29, 73),
      subtitleColor: Color.fromARGB(255, 161, 29, 73),
      background: LottieBuilder.asset("assets/a1.json")
    ),    CardPMovieData(
      title: "Mirar ahira",
      subtitle: "Miles de peliculas a tu alcanza y a la palma de tu mano.",
      image: const AssetImage("assets/icon3.jpg"),
      backgroundColor: const Color.fromARGB(255, 234, 63, 63),
      titleColor: const Color.fromARGB(255, 188, 139, 197),
      subtitleColor: Color.fromARGB(255, 188, 139, 197),
      background: LottieBuilder.asset("assets/a1.json")
    ),    CardPMovieData(
      title: "Realiza una Review",
      subtitle: "Realiza reviews de las peliculas vistas y puntua con estrellas.",
       image: const AssetImage("assets/icon4.png"),
      backgroundColor: Color.fromARGB(255, 85, 85, 85),
      titleColor: Color.fromARGB(227, 249, 226, 20),
      subtitleColor: const Color.fromARGB(227, 249, 226, 20),
      background: LottieBuilder.asset("assets/a1.json")
    )];
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
       colors: data.map((e) => e.backgroundColor).toList(),
      itemCount: data.length, // null = infinity
       
       itemBuilder: (int index) {
         return CardPlanet(data: data[index]);
       },
    ),
    );
  }
}