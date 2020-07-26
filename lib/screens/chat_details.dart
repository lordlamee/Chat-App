import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:chat_app/utilities/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat_app/services/chats_controller.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen({this.name, this.recipientId, this.chatId});

  final String name;
  final recipientId;
  String chatId;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textEditingController = TextEditingController();
  bool firstMessage = false;

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
            widget.name,
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
                    .document(widget.chatId)
                    .collection("messages")
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List messageDocuments = snapshot.data.documents;
                    List<MessageBubble> messages = [];
                    for (var message in messageDocuments) {
                      final messageText = message.data['content'];
                      final messageSender = message.data['senderId'];
                      final messageWidget = MessageBubble(
                        fromMe: userId == messageSender,
                        text: messageText,
                      );
                      messages.add(messageWidget);
                    }
                    return ListView(
                      reverse: true,
                      children: messages,
                    );
                  } else {
                    return Container();
                  }
                },
              )),
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
                        String message = textEditingController.text;
                        textEditingController.clear();
                        if (message != null && message.trim() != "") {
                          if (widget.chatId == "new chat") {
                            if (widget.recipientId != null) {
                              await sendFirstMessage(
                                  widget.recipientId, userId, message);
                            } else {
                              //generate recipient Id just in case
                              QuerySnapshot documentQuery = await fireStore
                                  .collection("users")
                                  .where("name", isEqualTo: widget.name)
                                  .getDocuments();
                              List<DocumentSnapshot> documents =
                                  documentQuery.documents;
                              String generatedRecipientId =
                                  documents[0].documentID;
                              //Generate chat Id for new chat
                              var generatedChatId = await sendFirstMessage(
                                  generatedRecipientId, userId, message);
                              setState(() {
                                widget.chatId = generatedChatId;
                              });
                            }
                          } else {
                            await fireStore
                                .collection("chats")
                                .document(widget.chatId)
                                .collection("messages")
                                .add({
                              "content": message,
                              "senderId": userId,
                              "timestamp": Timestamp.now()
                            });
                          }
                        }
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
