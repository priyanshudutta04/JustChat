
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/utils/chat_services.dart';
import 'package:just_chat/widgets/chat_bubble.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  const ChatPage({super.key, required this.receiverEmail, required this.receiverId,});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _message=TextEditingController();
  final ChatService _chatService=ChatService();
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  void sendMessage() async{
    if(_message.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverId, _message.text);
      _message.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      appBar: AppBar(
        title:
        Text(
          widget.receiverEmail,
          style: TextStyle(color: context.theme.primaryColor,fontSize: 18),
        ),
      ),

      body: Column(
        
        children: [

          Expanded(
            child: _messageList(),
          ),

          Row(
            children: [

              
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                    child: TextField(
                      //Mail
                      controller: _message,
                      decoration: InputDecoration(
                        labelText: "Enter Text",
                        labelStyle: TextStyle(
                          color: context.theme.primaryColor,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: context.theme.canvasColor,
                        prefixIcon: const Icon(Icons.message),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                              color: context.theme.dividerColor, width: 3.0),
                        ),
                      ),
                    ),            
                  ),
                ),

                IconButton(
                  onPressed: sendMessage, 
                  icon: Icon(Icons.send)
                )

            ],
          )

        ]
      ),
    );
  }

  Widget _messageList(){
    return StreamBuilder(
      stream: _chatService.getMessage(widget.receiverId, _firebaseAuth.currentUser!.uid), 
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text('Error'+snapshot.error.toString());
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Text('Loading...');
        }
        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((document) => _messageItem(document)).toList(),
        );
      }
    );
  }


  Widget _messageItem(DocumentSnapshot document){
    Map<String,dynamic> data=document.data() as Map<String,dynamic>;

    var alignment=(data['senderId'] == _firebaseAuth.currentUser!.uid)
      ? Alignment.centerRight
      : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? CrossAxisAlignment.end
        :CrossAxisAlignment.start,
        children: [
          //Text(data['senderEmail']),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Chatbubble(
              message: data['message'], 
              user: (data['senderId'] == _firebaseAuth.currentUser!.uid)?true:false
            ),
          )
        ],
      ),
    );

  }



}