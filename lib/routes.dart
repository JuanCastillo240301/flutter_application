import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/dashboard_screen.dart';
import 'package:flutter_application_3/screens/movie_details.dart';

Map<String,WidgetBuilder> getroutes(){
  return{
'/dash' : (BuildContext context) => const DashboardScreen(),
'/detail' : (BuildContext context) => movieDetails()
};
}