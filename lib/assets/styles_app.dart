import 'package:flutter/material.dart';

class stylesApp{
  static ThemeData lightTheme(BuildContext context){
final theme = ThemeData.light();
return theme.copyWith(
colorScheme: Theme.of(context).colorScheme.copyWith(
  primary: Color.fromARGB(255, 255, 0, 0),
  //(background: Color.fromARGB(255, 255, 100, 0)
)
);
  }

  static ThemeData darkTheme(BuildContext context){
    final theme = ThemeData.dark();
return theme.copyWith(
colorScheme: Theme.of(context).colorScheme.copyWith(
  primary: Color.fromARGB(98, 141, 3, 3),
  //(background: Color.fromARGB(255, 255, 100, 0)
)
);
  }
}