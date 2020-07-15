import 'package:chat_app/sign_in.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}
class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
    );
  }
}
