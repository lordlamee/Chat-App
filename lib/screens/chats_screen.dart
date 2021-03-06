import 'package:chat_app/authentication/sign_in.dart';
import 'package:chat_app/screens/new_chat.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:chat_app/utilities/widgets.dart';
import 'package:chat_app/view_model/chats_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewChat(),
              ));
        },
        child: Icon(FlutterIcons.new_message_ent),
      ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: InkResponse(
            onTap: () async {
              await signOutGoogle();
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
            child: Icon(Feather.log_out)),
        title: Text(
          'Dashboard',
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: StreamBuilder<QuerySnapshot>(
          stream: fireStore
              .collection("chats")
              .where("users", arrayContains: userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List chatDocuments = snapshot.data.documents;
              if (chatDocuments.isNotEmpty) {
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: chatDocuments.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot chatDoc = chatDocuments[index];
                      return StreamBuilder<DocumentSnapshot>(
                        stream: fireStore
                            .collection("chats")
                            .document(chatDoc.documentID)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List users = snapshot.data.data["users"];
                            users.remove(userId.toString());
                            var recipientId = users[0];
                            return StreamBuilder<DocumentSnapshot>(
                              stream: fireStore
                                  .collection("users")
                                  .document(recipientId)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map recipientDocument = snapshot.data.data;
                                  var recipientName = recipientDocument["name"];
                                  var recipientPhotoUrl =
                                      recipientDocument["photoUrl"];
                                  ChatTile newChatTile = ChatTile(
                                    chatId: chatDoc.documentID,
                                    recipientId: recipientId,
                                    messagePreview: "new message",
                                    name: recipientName,
                                    image: NetworkImage(
                                        recipientPhotoUrl.toString()),
                                    messageTime: "2:00pm",
                                  );
                                  return newChatTile;
                                } else {
                                  return Container();
                                }
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    });
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
