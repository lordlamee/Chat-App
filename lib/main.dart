import 'package:flutter/material.dart';
import 'chats_screen.dart';

void main() {
  runApp(ChatApp());
}
class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Chats(),
    );
  }
}
