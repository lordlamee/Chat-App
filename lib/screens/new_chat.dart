import 'package:chat_app/services/chats_controller.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:chat_app/utilities/widgets.dart';
import 'package:chat_app/view_model/chats_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewChat extends StatefulWidget {
  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  TextEditingController _controller = TextEditingController();

  String searchParameter;

  @override
  void initState() {
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
        child: SingleChildScrollView(
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}


















//Container(
//height: 300,
//child: StreamBuilder<QuerySnapshot>(
//stream: fireStore
//    .collection("chats")
//.where("users", arrayContains: userId)
//.snapshots(),
//builder: (context, snapshot) {
//if (snapshot.hasData) {
//List<DocumentSnapshot> chatDoc = snapshot.data.documents;
//for (var data in chatDoc) {
//var recipientName = data.data["name"];
//var recipientPhotoUrl = data.data["photoUrl"];
//if (recipientName != userName) {
//ChatTile newChatTile = ChatTile(
//chatId: "new chat",
//recipientId: data.documentID,
//messagePreview: "new message",
//name: recipientName,
//image: NetworkImage(recipientPhotoUrl.toString()),
//messageTime: "2:00pm",
//);
//if (!ChatsData()
//    .allChatTiles
//    .contains(newChatTile.name)) {
//Provider.of<ChatsData>(context, listen: false)
//    .addNewChatTile(newChatTile);
//}
//}
//}
//return Consumer<ChatsData>(
//builder: (context, chatsData, child) {
//newChatSearch(searchParameter, chatsData.chats);
//return ListView.separated(
//itemBuilder: (context, index) {
//return chatsData.chats[index];
//},
//separatorBuilder: (context, index) => Divider(),
//itemCount: chatsData.chats.length);
//});
//} else {
//return CircularProgressIndicator();
//}
//},
//),
//),