import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/model/message.dart';

class ChatService extends ChangeNotifier{

  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final FirebaseFirestore _fireStore= FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverId, String message) async{
    //get current user info
    final String currentUserId =_firebaseAuth.currentUser!.uid;
    final String currentUseremail=_firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp=Timestamp.now();

    //create message
    Message newMessage=Message(
      senderId: currentUserId,
      senderEmail: currentUseremail,
      receiverId:receiverId,
      timestamp: timestamp,
      message: message,
    );

    //construct chat room id
    List<String> ids=[currentUserId,receiverId];
    ids.sort();
    String chatRoomId=ids.join("_");
    await _fireStore.collection('chat_rooms')
      .doc(chatRoomId).collection('messages').add(newMessage.toMap());
  }

  //get message
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId){

    List<String> ids=[userId,otherUserId];
    ids.sort();
    String chatRoomId=ids.join("_");

    return _fireStore.collection('chat_rooms')
      .doc(chatRoomId).collection('messages').orderBy('timestamp',descending: false).snapshots();

  }



}