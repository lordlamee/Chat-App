import 'package:chat_app/chat_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return InkResponse(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(
          builder: (context) => ChatScreen(name: name,)
        ),);
      },
      child: Row(
        children: <Widget>[
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
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
                    Text(messageTime,style: GoogleFonts.rubik(color: textColor.withOpacity(0.4),),)
                  ],
                ),
                Text(messagePreview,style: GoogleFonts.rubik(color: textColor.withOpacity(0.4),),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(),
        ),
      ],
    );
  }
}
