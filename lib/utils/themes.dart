// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}


class MyThemes {
  static final lightTheme = ThemeData(
      primarySwatch:
          Colors.deepPurple, // changes all colours with respect to given colour
      //colours for light theme
      primaryColor: Color.fromRGBO(41, 30, 41, 1), //text colour
      cardColor: Color.fromRGBO(238, 238, 238, 1), //background colour
      canvasColor: Color.fromRGBO(255, 255, 255, 1),
      splashColor: Color.fromRGBO(139, 97, 255, 1), // button colour changed to splash colour due to deprication
      dividerColor:Color.fromRGBO(97, 255, 163, 1), //Alternate colour for list tile
      unselectedWidgetColor: Colors.purpleAccent,
      focusColor: Colors.deepPurple, //active colour for  checkbox
      // primaryTextTheme: GoogleFonts.sourceSansProTextTheme(),
      appBarTheme: AppBarTheme(
        color: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.deepPurple),
      )
      // textTheme: GoogleFonts.workSans(
      //   Theme.of(context).textTheme
      // ),
      );
      

  static final darkTheme = ThemeData(
      primarySwatch: Colors.deepOrange,
      brightness: Brightness.dark,
      //colours for dark theme
      primaryColor: Color.fromRGBO(245, 245, 245, 1), //text color
      cardColor: Color.fromRGBO(17, 17, 17, 1), //background colour
      canvasColor: Color.fromRGBO(30, 30, 30, 1),
      splashColor: Color.fromARGB(255, 245, 175, 75), // button colour changed to splash colour due to deprication
      dividerColor:
          Color.fromRGBO(66, 66, 66, 1), //Alternate colour for list tile
      unselectedWidgetColor: Colors.red,
      focusColor: Colors.red, //active colour for  checkbox
      // primaryTextTheme: GoogleFonts.sourceSansProTextTheme(),
      appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.red)));
}
