import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/pages/home_page.dart';
import 'package:just_chat/utils/loginOrregister.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user logged in or not
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const LoginOrRegister();//Loginpage
            }
          }),
    );
  }
}
