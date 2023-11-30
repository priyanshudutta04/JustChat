
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
   final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  

  //User Sign in firebase
  void signUserIn() async {

     final FirebaseFirestore _fireStore=FirebaseFirestore.instance;
    //show dialog
    showDialog(
        context: context,
        builder: ((context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
    
    try {
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text, 
        password: passwordcontroller.text
      );

              
       _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : emailcontroller.text,
       });

      Navigator.pop(context);
    } 
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmail();
      } else if (e.code == 'wrong-password') {
        wrongPass();
      }
    }
  }

  //void registerUser(){
  // Navigator.popAndPushNamed(context.theme, "/register");
  // }

  void wrongEmail() {
    showDialog(
        context: context,
        builder: ((context) {
          return const AlertDialog(
            title: Text("Incorrect Email"),
          );
        }));
  }

  void wrongPass() {
    showDialog(
        context: context,
        builder: ((context) {
          return const AlertDialog(
            title: Text("Wrong password"),
          );
        }));
  }

  void goHome() {
    setState(() {});
    Future.delayed(const Duration(seconds: 1));
     Navigator.pushNamed(context, Myroutes.homeRoute);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.cardColor,
        //logo
        body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, right: 0, left: 0, bottom: 0),
                  child: Image.asset(
                    //top image
                    context.isDarkMode
                        ? "assets/images/app_logo.png"
                        : "assets/images/app_logo.png",
                    fit: BoxFit.contain,
                    height: 300,
                    width: 300,
                  ),
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 24,
                    color: context.theme.primaryColor,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                  child: TextField(
                    //Mail
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: context.theme.primaryColor,
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: context.theme.canvasColor,
                      prefixIcon: const Icon(Icons.person),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                            color: context.theme.dividerColor, width: 3.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    //password
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: context.theme.primaryColor,
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: context.theme.canvasColor,
                      prefixIcon: const Icon(Icons.remove_red_eye),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                            color: context.theme.dividerColor, width: 3.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  //sign in button
                  onTap: signUserIn,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: context.theme.splashColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: context.theme.canvasColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: context.theme.primaryColor,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or continue with"),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  //google login
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        // Future.delayed(const Duration(milliseconds: 800), () {
                        //   setState(() {
                        //     AuthService().signInGoogle();
                        //     isLoading = false;
                        //   });
                        // });
                      },
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: context.theme.canvasColor),
                              color: context.theme.canvasColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text(
                                      'Loading...',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    const CircularProgressIndicator(
                                      color: Colors.purple,
                                    ),
                                  ],
                                )
                              : Row(children: [
                                  Image.asset(
                                    "assets/images/google.png",
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Google",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ])),
                    )
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  //Sign In
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text("Not a member?"),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                              color: context.theme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
