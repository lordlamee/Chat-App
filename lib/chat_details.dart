import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/chats_controller.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:chat_app/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({this.name});

  final String name;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    //  getChats();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: InkResponse(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: fireStore
                  .collection("chats")
                  .where("users", arrayContains: "user1id")
                  .snapshots(),
                  builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List chatSnapshotDocuments = snapshot.data.documents;
                  if (chatSnapshotDocuments.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: chatSnapshotDocuments.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot messageDocument =
                            chatSnapshotDocuments[index];
                        return StreamBuilder<QuerySnapshot>(
                          stream: fireStore
                              .collection("chats")
                              .document(messageDocument.documentID)
                              .collection("messages")
                              .orderBy("timestamp", descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<DocumentSnapshot> message =
                                  snapshot.data.documents;
                              List<Widget> messageBubbles = [];
                              for (var data in message) {
                                var text = data.data["content"];
                                Widget messageBubble = MessageBubble(
                                  fromMe: true,
                                  text: text,
                                );
                                messageBubbles.add(messageBubble);
                              }
                              return Container(
                                constraints: BoxConstraints.expand(
                                  width: double.infinity,
                                  height: screenSize.height - screenSize.height * 0.24,
                                ),
                                child: ListView(
                                  reverse: true,
                                  children: messageBubbles,
                                ),
                              );
                            } else {
                              return Container(
                                child: Text('stuff has no data'),
                              );
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Container(
                      child: Center(child: Text('working on it')),
                    );
                  }
                } else {
                  return Container(
                    child: Text('No Users Here'),
                  );
                }
                  },
                ),
              ),
              Container(
                height: screenSize.height * 0.08,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black.withOpacity(0.05)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        // await sendMessage();
                        textEditingController.clear();
                      },
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
//ListView(
//children: <Widget>[
//MessageBubble(
//fromMe: true,
//),
//MessageBubble(
//fromMe: false,
//),
//MessageBubble(
//fromMe: true,
//),
//MessageBubble(
//fromMe: false,
//),
//MessageBubble(
//fromMe: true,
//),
//MessageBubble(
//fromMe: false,
//),
//],
//),
