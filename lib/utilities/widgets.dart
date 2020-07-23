import 'package:chat_app/models/models.dart';
import 'package:chat_app/screens/chat_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
Map<String,String> testMap = {
  "name" : "Olamide",
  "photoUrl" : "google.com"
};
Size screenSize;
const appBarColor = Color(0xFF2B3595);
const textColor = Color(0xFF062743);
final appBarTextStyle = GoogleFonts.rubik(
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

class ChatTile extends StatelessWidget {
  ChatTile({this.image, this.name, this.messageTime, this.messagePreview});

  final ImageProvider image;
  final String name;
  final String messageTime;
  final String messagePreview;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () async{

        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ChatScreen(
                    name: name,
                  ),),
        );
      },
      child: Row(
        children: <Widget>[
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: image,
              ),
              //image: DecorationImage(image: image),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      name,
                      style: GoogleFonts.rubik(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      messageTime,
                      style: GoogleFonts.rubik(
                        color: textColor.withOpacity(0.4),
                      ),
                    )
                  ],
                ),
                Text(
                  messagePreview,
                  style: GoogleFonts.rubik(
                    color: textColor.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.fromMe,this.message,this.text});

  final bool fromMe;
  final Message message;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        fromMe
            ? Material(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: appBarColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                   text ,
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Row(
                children: <Widget>[
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                     // image: DecorationImage()
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Material(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: textColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Text(
                        'Hello there',
                        style: GoogleFonts.manrope(color: textColor),
                      ),
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
