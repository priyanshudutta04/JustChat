// ignore_for_file: prefer_const_constructors


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/firebase_options.dart';
import 'package:just_chat/pages/home_page.dart';
import 'package:just_chat/utils/auth_services.dart';
import 'package:just_chat/utils/authenticate.dart';
import 'package:just_chat/utils/routes.dart';
import 'package:just_chat/utils/themes.dart';


import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp
  (
 MyApp()
  );

}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            
            debugShowCheckedModeBanner: false, //removes debug banner

            initialRoute: "/", //this route will open first

            routes: {
              //creating routes for different pages in app
              "/": (context) => AuthPage(), //main root
              // Myroutes.loginRoute: (context) => LoginPage(),
              // Myroutes.registerRoute: (context) => RegisterPage(),
              Myroutes.registerRoute: (context) => HomePage(),

            },
          );
        },
      );
}
