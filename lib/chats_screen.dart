import 'package:chat_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: Icon(FlutterIcons.log_out_fea),
        title: Text('Dashboard', style: appBarTextStyle,),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,0),
        child: ListView.separated(
          separatorBuilder: (context,index) => SizedBox(height: 20,),
          itemBuilder: (context, index) => ChatTile(
            name: 'Gabriel Olamide',
            messageTime: '2:00pm',
            messagePreview: 'new message',
          ),
          itemCount: 8,
        ),
      ),
    );
  }
}
