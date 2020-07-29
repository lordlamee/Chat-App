import 'dart:async';

import 'package:chat_app/screens/chats_screen.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'authentication/sign_in.dart';

void main() {
  runApp(ChatApp());
}
class ChatApp extends StatefulWidget {
  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {

  Future<Widget> returnFirstPage()async{
     Widget firstPage = await checkForUser().then((value){
       if (value == null){
         return SignIn();
       }else{
         return Chats();
       }
     });
     if (firstPage == null){
       return Container(
         color: Colors.green,
       );
     }else{
       return firstPage;
     }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<Widget>(
        future: returnFirstPage(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return snapshot.data;
          }else {
            return Scaffold(
              backgroundColor: Colors.white,
                body : CircularProgressIndicator(
                 // backgroundColor: appBarColor,
                ));
          }
        },
      )
    );
  }
}

