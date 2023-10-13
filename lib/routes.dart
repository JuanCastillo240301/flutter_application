import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/Carrera_screen.dart';
import 'package:flutter_application_3/screens/Detail_Movie_Screen.dart';
import 'package:flutter_application_3/screens/School_dashboard_Screen.dart';
import 'package:flutter_application_3/screens/Test_Provider_screen.dart';
import 'package:flutter_application_3/screens/add_Carrera.dart';
import 'package:flutter_application_3/screens/add_task.dart';
import 'package:flutter_application_3/screens/dashboard_screen.dart';
import 'package:flutter_application_3/screens/login_page.dart';
import 'package:flutter_application_3/screens/movie_details.dart';
import 'package:flutter_application_3/screens/popular_screen.dart';
import 'package:flutter_application_3/screens/task_screen.dart';

Map<String, WidgetBuilder> getroutes() {
  return {
    '/dash': (BuildContext context) => const DashboardScreen(),
    '/detail': (BuildContext context) => movieDetails(),
    '/task': (BuildContext context) => const TaskScreen(),
    '/add': (BuildContext context) => AddTask(),
    '/loginpage': (BuildContext context) => const LoginPage(),
    '/popular': (BuildContext context) => const PopularScreen(),
    '/detailMovie': (BuildContext context) => const DetailMovieScreen(),
    '/testP': (BuildContext context) => const TestProviderScreen(),
    '/School': (BuildContext context) => const SchoolDashboardScreen(),
    '/add_Carrera': (BuildContext context) => AddCarrera(),
    '/carrera': (BuildContext context) => const CarreraScreen(),
  };
}
