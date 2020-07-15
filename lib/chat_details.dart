import 'package:chat_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: Icon(Icons.arrow_back_ios),
          title: Text(
            name,
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    MessageBubble(
                      fromMe: true,
                    ),
                    MessageBubble(
                      fromMe: false,
                    ),
                    MessageBubble(
                      fromMe: true,
                    ),
                    MessageBubble(
                      fromMe: false,
                    ),
                    MessageBubble(
                      fromMe: true,
                    ),
                    MessageBubble(
                      fromMe: false,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black.withOpacity(0.05)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Send',
                        style: GoogleFonts.manrope(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
