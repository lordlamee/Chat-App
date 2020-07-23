import 'package:chat_app/screens/new_chat.dart';
import 'package:chat_app/services/chats_controller.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:chat_app/utilities/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
            onTap: () {
              signOutGoogle();
              Navigator.pop(context);
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
                                  var recipientName =
                                      snapshot.data.data["name"];
                                  var recipientPhotUrl =
                                      snapshot.data.data["photoUrl"];
                                  return ChatTile(
                                    messagePreview: "new message",
                                    name: recipientName,
                                    image: NetworkImage(
                                        recipientPhotUrl.toString()),
                                    messageTime: "2:00pm",
                                  );
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
              return Container(
                color: Colors.green,
              );
            }
          },
        ),
      ),
    );
  }
}

//
//StreamBuilder<QuerySnapshot>(
//stream: fireStore.collection("users").snapshots(),
//builder: (context, snapshot) {
//if (snapshot.hasData) {
//var usersData = snapshot.data.documents;
//List<Widget> chatTiles = [];
//for (var data in usersData) {
//var username = data.data["name"];
//var photoUrl = data.data["photoUrl"];
//if (username != userName) {
//Widget chatTile = ChatTile(
//name: username.toString(),
//messageTime: '2:00pm',
//messagePreview: 'new message',
//image: NetworkImage(photoUrl.toString()),
//);
//chatTiles.add(chatTile);
//}
//}
//return ListView.separated(
//itemCount: chatTiles.length,
//itemBuilder: (context, index) {
//return chatTiles[index];
//},
//separatorBuilder: (context, index) => Divider(
//height: 20,
//),
//shrinkWrap: true,
//);
//} else {
//return Container(
//child: Text('No Users Here'),
//);
//}
//},
//),
