import 'package:chat_app/services/chats_controller.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:chat_app/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getChats();
    return Scaffold(
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
          child: Column(
            children: <Widget>[
              TextFormField(

              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: fireStore.collection("users").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var usersData = snapshot.data.documents;
                      List<Widget> chatTiles = [];
                      for (var data in usersData) {
                        var username = data.data["name"];
                        var photoUrl = data.data["photoUrl"];
                        if (username != userName) {
                          Widget chatTile = ChatTile(
                            name: username.toString(),
                            messageTime: '2:00pm',
                            messagePreview: 'new message',
                            image: NetworkImage(photoUrl.toString()),
                          );
                          chatTiles.add(chatTile);
                        }
                      }
                      return ListView.separated(
                        itemCount: chatTiles.length,
                        itemBuilder: (context, index) {
                          return chatTiles[index];
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 20,
                        ),
                        shrinkWrap: true,
                      );
                    } else {
                      return Container(
                        child: Text('No Users Here'),
                      );
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
//ListView.separated(
//separatorBuilder: (context,index) => SizedBox(height: 20,),
//itemBuilder: (context, index) => ChatTile(
//name: 'Gabriel Olamide',
//messageTime: '2:00pm',
//messagePreview: 'new message',
//),
//itemCount: 8,
//),
