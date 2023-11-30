import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Chatbubble extends StatelessWidget {
  final String message;
  final bool user;
  const Chatbubble({super.key, required this.message,required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 50, maxWidth: 200),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: user==true? context.theme.dividerColor: context.theme.splashColor,
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          color: context.theme.canvasColor,
        ),
      ),
    );
  }
}