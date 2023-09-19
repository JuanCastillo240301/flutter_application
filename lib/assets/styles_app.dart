import 'package:flutter/material.dart';

class stylesApp{
  static ThemeData lightTheme(BuildContext context){
final theme = ThemeData.light();
return theme.copyWith(
colorScheme: Theme.of(context).colorScheme.copyWith(
  primary: Color.fromARGB(255, 224, 0, 0),
  secondary: Color.fromARGB(0, 255, 255, 255), 
  //(background: Color.fromARGB(255, 255, 100, 0)
)
);
  }

  static ThemeData darkTheme(BuildContext context){
    final theme = ThemeData.dark();
return theme.copyWith(
colorScheme: Theme.of(context).colorScheme.copyWith(
  primary: Color.fromARGB(255, 224, 0, 0),
  secondary: Color.fromARGB(0, 255, 255, 255), 
  //(background: Color.fromARGB(255, 255, 100, 0)
)
);
  }
}