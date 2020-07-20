import 'package:chat_app/screens/new_chat.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/utilities/widgets.dart';
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
          child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => SizedBox(
              height: 20,
            ),
            itemBuilder: (context, index) => ChatTile(
              name: userName,
              messageTime: '2:00pm',
              messagePreview: 'new message',
              image: NetworkImage(photoUrl.toString()),
            ),
            itemCount: 8,
          )),
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
