
import 'package:chat_app/screens/chat_details.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'authentication/sign_in.dart';

void main() {
  runApp(ChatApp());
}
class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: appUser == null ? SignIn() : ChatScreen(),
    );
  }
}
