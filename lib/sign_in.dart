import 'package:chat_app/chats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'services/sign_in_service.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton.icon(
          onPressed: (){
            signInWithGoogle().whenComplete(() => Navigator.push(context, CupertinoPageRoute(builder: (context) => Chats())));
          },
          icon: ImageIcon(AssetImage('assets/google_logo.png'),),
          label: Text('Sign In with Google')
        ),
      ),
    );
  }
}
