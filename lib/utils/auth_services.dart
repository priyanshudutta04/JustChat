import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthService{

  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  final FirebaseFirestore _fireStore=FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmail(String email, String pwd) async{

    try{
      UserCredential userCredential=
        await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pwd);
        _fireStore.collection('users').doc(userCredential.user!.uid);
        return userCredential;
    } 
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }

  }



  //google Sign in
  // signInGoogle() async{

  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: gAuth.accessToken,
  //     idToken: gAuth.idToken,
  //   );

  //   return await FirebaseAuth.instance.signInWithCredential(credential);

  // }
}