import 'package:chat_app/screens/chats_screen.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:chat_app/view_model/chats_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/sign_in_service.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: RaisedButton.icon(
              onPressed: () async {
                FirebaseUser userSigningIn = await signInWithGoogle();
                setState(() {
                  appUser = userSigningIn;
                });
                storeUserDetails();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Chats()));
              },
              icon: ImageIcon(
                AssetImage('assets/google_logo.png'),
              ),
              label: Text('Sign In with Google')),
        ),
      );
  }
}
