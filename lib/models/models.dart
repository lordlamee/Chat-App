import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String content;
  String senderId;
  Timestamp timestamp;
  Message({this.content,this.senderId,this.timestamp});

   Message.fromJson(Map<String,dynamic> json){
     content = json["content"];
     senderId = json["senderId"];
     timestamp = json["timestamp"];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data["content"] = this.content;
    data["senderId"] = this.senderId;
    data["timestamp"] = this.timestamp;
    return data;
  }

}