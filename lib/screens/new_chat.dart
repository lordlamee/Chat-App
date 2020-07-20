import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets.dart';

class NewChat extends StatefulWidget {
  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  TextEditingController _controller = TextEditingController();

  String searchParameter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      setState(() {
        searchParameter = _controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.5),
                    hintText: 'Search',
                    hintStyle: GoogleFonts.rubik(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: fireStore.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var usersData = snapshot.data.documents;
                    List<ChatTile> chatTiles = [];
                    for (var data in usersData) {
                      var username = data.data["name"];
                      var photoUrl = data.data["photoUrl"];
                      if (username != userName) {
                        ChatTile chatTile = ChatTile(
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
                        return searchParameter == null || searchParameter == ""
                            ? chatTiles[index]
                            : chatTiles[index].name.toLowerCase().contains(searchParameter.toLowerCase())
                                ? chatTiles[index]
                                : SizedBox();
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
            ],
          ),
        ),
      ),
    );
  }
}