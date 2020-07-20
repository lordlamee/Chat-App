import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getChats() async {
  // final chats =  fireStore.collection("users").snapshots();
  //  final chats =  fireStore.collection("users").getDocuments();
//   await for (var user in chats){
//     for(var  name in user.documents){
//      print(name.data["name"]);
//    }
//   }

//  final test = await fireStore
//      .collection("chats")
//      .where("users", arrayContains: "user1id")
//      .getDocuments();
//  final myTest =  fireStore
//      .collection("chats")
//      .document('yACai6JdSaMfd2q9Vdbp')
//      .collection("messages")
//      .orderBy("timestamp", descending: true)
//      .snapshots();
//     await for (var user in myTest){
//     for(var  name in user.documents){
//       print(name.data["content"]);
//    }
//   }
//   final messageTest = await fireStore.collection("chats").where("users", arrayContains: "user1id").getDocuments();
//   for (var document in messageTest.documents){
//     final messages = await document.reference.collection("messages").getDocuments();
//      for( var message in messages.documents)
//     print(message.data["content"]);
//   }
  final Stream<QuerySnapshot> messageTest2 = fireStore
      .collection("chats")
      .where("users", arrayContains: "user1id")
      .snapshots();
  await for (var data in messageTest2) {
    for (var document in data.documents) {
      print(document.reference.collection("messages"));
    }
  }
  // final messages = messageTest2.data;

//  await for (var user in messageTest){
//    for(var  name in user.documents){
//      print(name.data["content"].toString());
//    }
//  }
  //  final messageCollection = t
}

searchUser(String name) {
  fireStore.collection("users").where("name", ).getDocuments();
}

sendMessage(Message message, String documentId) async {
  await fireStore
      .collection("chats")
      .document(documentId)
      .collection("messages")
      .add(message.toJson());
}

getChatDetailId() {}
