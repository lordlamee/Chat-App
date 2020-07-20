
import 'package:flutter/material.dart';
import 'authentication/sign_in.dart';

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
