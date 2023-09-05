import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/styles_app.dart';
import 'package:flutter_application_3/routes.dart';
import 'package:flutter_application_3/screens/card_movies.dart';
import 'package:flutter_application_3/screens/login_screen.dart';
import 'package:concentric_transition/concentric_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  home(),
      //home: const LoginScreen(),
      routes: 
        getroutes()
      ,theme: stylesApp.darkTheme(context)
    );
  }
}

class home extends StatelessWidget {
   home({super.key}) ;


final data = [
    CardPlanetData(
      title: "observe",
      subtitle:
          "The night sky has much to offer to those who seek its mystery.",
      image: const AssetImage("assets/icon1.png"),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
    ),    CardPlanetData(
      title: "imagine",
      subtitle: "An endless number of galaxies means endless possibilities.",
      image: const AssetImage("assets/icon1.png"),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
    ),    CardPlanetData(
      title: "stargaze",
      subtitle: "The sky dome is a beautiful graveyard of stars.",
       image: const AssetImage("assets/icon1.png"),
      backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
    )];
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
       colors: data.map((e) => e.backgroundColor).toList(),
      itemCount: 3, // null = infinity
       
       itemBuilder: (int index) {
         return CardPlanet(data: data[index]);
       },
    ),
    );
  }
}