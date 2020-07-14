import 'package:chat_app/widgets.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: Icon(Icons.arrow_back_ios),
        title: Text(name,style: appBarTextStyle,),
        centerTitle: true,
      ),
    );
  }
}
