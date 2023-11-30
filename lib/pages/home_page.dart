

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/pages/chat_page.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    final FirebaseAuth _auth= FirebaseAuth.instance;

    void signUserout() async {
    FirebaseAuth.instance.signOut();
    // Future.delayed(Duration(seconds: 1));
    // Navigator.pushNamed(context, Myroutes.loginRoute);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        title: Text("JustChat",
          style: TextStyle(color: context.theme.primaryColor,fontSize: 24),),
        actions: [
          IconButton(onPressed: signUserout, icon: Icon(Icons.logout))
        ],
      ),
      

      body: Column(
        children: [
          SizedBox(height: 30,),
          Expanded(child: _buildUserList()),
        ],
      ),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return const Text('error');
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Text('loading...');
        }
        return ListView(
          children: snapshot.data!.docs
            .map<Widget>((doc)=> _buildUserListItem(doc))
            .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data=document.data()! as Map<String, dynamic>;

    if(_auth.currentUser!.email !=data['email']){
      return ListTile(
        title: Text(data['email']),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(
            receiverEmail: data['email'],
            receiverId: data['uid'],

          )));
        },
      );
    } else{
      return Container();
    }
  }
}